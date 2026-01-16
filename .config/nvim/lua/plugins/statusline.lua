local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local diag_icons = {
	[vim.diagnostic.severity.ERROR] = "",
	[vim.diagnostic.severity.WARN] = "",
	[vim.diagnostic.severity.INFO] = "󰋇",
	[vim.diagnostic.severity.HINT] = "󰌵",
}

vim.diagnostic.config({
	signs = {
		text = diag_icons,
	},
})

local space = {
	provider = " ",
}

local align = {
	provider = "%=",
}

local vimode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,

	static = {
		mode_names = {
			n = "N",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "V",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "I",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "C",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		},
		mode_colors = {
			n = "red",
			i = "green",
			v = "cyan",
			V = "cyan",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},

	provider = function(self)
		return "  %-3(" .. self.mode_names[self.mode] .. "%)"
	end,

	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = self.mode_colors[mode], bold = true }
	end,

	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

local fileicon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local filenamemodifier = {
	hl = function()
		if vim.bo.modified then
			return {
				fg = "cyan",
				bold = true,
				force = true,
			}
		end
	end,
}

local fileflags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		hl = {
			fg = "green",
		},
	},
	{
		condition = function()
			return not vim.bo.modified or vim.bo.readonly
		end,
		provider = " ",
		hl = {
			fg = "orange",
		},
	},
}

local filename = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")

		if filename == "" then
			return "[No Name]"
		end

		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end

		return filename
	end,
	hl = {
		fg = utils.get_highlight("Directory").fg,
	},
}

local filenameblock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	fileicon,
	space,
	utils.insert(filenamemodifier, filename),
	space,
	fileflags,
	{
		provider = "%<",
	},
}

local filetype = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = {
		fg = utils.get_highlight("Type").fg,
		bold = true,
	},
}

local fileencoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
		return enc:upper()
	end,
}

local fileformat = {
	provider = function()
		local fmt = vim.bo.fileformat
		return fmt:upper()
	end,
}

local formatblock = {
	filetype,
	space,
	fileencoding,
	space,
	fileformat,
}

local ruler = {
	provider = "%3l/%-3L:%-3c │ %P",
}

local activeLSP = {
	condition = conditions.lsp_attached(),
	update = { "LspAttach", "LspDetach" },
	provider = function()
		local names = {}
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in ipairs(clients) do
			if client.name ~= "null-ls" then
				table.insert(names, client.name)
			end
		end
		return "[" .. table.concat(names, " ") .. "]"
	end,
	hl = { fg = "green", bold = true },
}

local diagnostics = {
	condition = conditions.has_diagnostics,

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

		self.error_icon = diag_icons[vim.diagnostic.severity.ERROR]
		self.warn_icon = diag_icons[vim.diagnostic.severity.WARN]
		self.info_icon = diag_icons[vim.diagnostic.severity.INFO]
		self.hint_icon = diag_icons[vim.diagnostic.severity.HINT]
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = "",
	},
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and self.error_icon .. " " .. self.errors .. " "
		end,
		hl = { fg = "diag_error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and self.warn_icon .. " " .. self.warnings .. " "
		end,
		hl = { fg = "diag_warn" },
	},
	{
		provider = function(self)
			return self.info > 0 and self.info_icon .. " " .. self.info .. " "
		end,
		hl = { fg = "diag_info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and self.hint_icon .. " " .. self.hints
		end,
		hl = { fg = "diag_hint" },
	},
	{
		provider = "",
	},
}

local separator_r = {
	provider = "",
	hl = { fg = "bright_bg" },
}

local separator_l = {
	provider = "",
	hl = { fg = "bright_bg" },
}

local M = {
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,

	fallthrough = false,
	{
		{
			space,
			vimode,
			hl = { bg = "bright_bg" },
		},
		{
			provider = "",
			hl = { fg = "bright_bg" },
		},
		space,
		diagnostics,
		space,
		filenameblock,
		space,
		{
			provider = "",
			hl = { fg = "bright_bg" },
		},
		{
			align,
			hl = { bg = "bright_bg" },
		},
		{
			provider = "",
			hl = { fg = "bright_bg" },
		},
		space,
		activeLSP,
		space,
		formatblock,
		space,
		{
			provider = "",
			hl = { fg = "bright_bg" },
		},
		{
			ruler,
			space,
			hl = { bg = "bright_bg" },
		},
	},
}

return M
