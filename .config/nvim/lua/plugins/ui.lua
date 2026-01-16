local function setup_statusline()
	local heirline = require("heirline")
	local h_utils = require("heirline.utils")

	local opts = {
		statusline = require("plugins.statusline"),
		-- statuscolumn = {},
	}

	local function setup_colors()
		return {
			bright_bg = h_utils.get_highlight("Folded").bg,
			bright_fg = h_utils.get_highlight("Folded").fg,
			red = h_utils.get_highlight("DiagnosticError").fg,
			dark_red = h_utils.get_highlight("DiffDelete").bg,
			green = h_utils.get_highlight("String").fg,
			blue = h_utils.get_highlight("Function").fg,
			gray = h_utils.get_highlight("NonText").fg,
			orange = h_utils.get_highlight("Constant").fg,
			purple = h_utils.get_highlight("Statement").fg,
			cyan = h_utils.get_highlight("Special").fg,
			diag_warn = h_utils.get_highlight("DiagnosticWarn").fg,
			diag_error = h_utils.get_highlight("DiagnosticError").fg,
			diag_hint = h_utils.get_highlight("DiagnosticHint").fg,
			diag_info = h_utils.get_highlight("DiagnosticInfo").fg,
			git_del = h_utils.get_highlight("diffDeleted").fg,
			git_add = h_utils.get_highlight("diffAdded").fg,
			git_change = h_utils.get_highlight("diffChanged").fg,
		}
	end

	vim.api.nvim_create_augroup("Heirline", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			h_utils.on_colorscheme(setup_colors)
		end,
		group = "Heirline",
	})

	heirline.load_colors(setup_colors())
	heirline.setup(opts)
end

local function setup_harpoon()
	local harpoon = require("harpoon")
	harpoon:setup()

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end)
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	for i = 1, 5 do
		vim.keymap.set("n", "<leader>" .. i, function()
			harpoon:list():select(i)
		end)
	end

	vim.keymap.set("n", "<TAB>", function()
		harpoon:list():next()
	end)
	vim.keymap.set("n", "<S-TAB>", function()
		harpoon:list():prev()
	end)
end

return {
	{
		"rebelot/heirline.nvim",
		config = setup_statusline,
	},
	{
		"Bekaboo/dropbar.nvim",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup_harpoon,
	},
}
