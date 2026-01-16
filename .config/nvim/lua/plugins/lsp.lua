local install = {
	-- lua
	"lua-language-server", -- lua_ls
	"stylua",

	-- c/c++
	"clangd",
	"codelldb",
	"cpplint",
	"clang-format",
	"qmlls",

	-- go
	"gopls",
	"gofumpt",
	"golines",
	"goimports-reviser",

	-- etc
	"prettier",

	-- python
	"jedi-language-server",
	"black",
	"ruff",

	-- js bullshit
	"typescript-language-server",
	"oxlint",
}

local function setup_mason()
	require("mason").setup({
		ui = {
			icons = {
				package_pending = " ",
				package_installed = "󰄳 ",
				package_uninstalled = "󰚌",
			},
		},
		max_concurrent_installers = 10,
	})

	vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(install, " "))
	end, {})
end

local function setup_lsp()
	local lspconfig = require("lspconfig")

	require("mason-lspconfig").setup({
		automatic_installation = true,
		handlers = {
			function(server_name)
				lspconfig[server_name].setup({})
			end,

			["gopls"] = function()
				lspconfig.gopls.setup({
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmlp" },
					root_di = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
				})
			end,

			["clangd"] = function()
				lspconfig.clangd.setup({
					capabilities = {
						textDocument = {
							formatting = { dynamicRegistration = false },
							rangeFormatting = { dynamicRegistration = false },
						},
					},
					on_new_config = function(new_config, new_cwd)
						local status, cmake = pcall(require, "cmake-tools")
						if status then
							cmake.clangd_on_new_config(new_config)
						end
					end,
				})
			end,

			["ruff"] = function()
				lspconfig.ruff.setup({
					filetypes = { "python" },
				})
			end,

			["oxlint"] = function()
				lspconfig.oxlint.setup({
					filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact", "typescript.tsx" },
				})
			end,

			["jedi_language_server"] = function()
				lspconfig.jedi_language_server.setup({
					filetypes = { "python" },
				})
			end,

			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact", "typescript.tsx" },
				})
			end,

			["qmlls"] = function()
				lspconfig.qmlls.setup({
					filetypes = { "qml" },
				})
			end,
		},
	})

	-- lspconfig.lua_ls.setup({})
end

_G.null_ls_formatting_enabled = true

local function ToggleNullLsFormatting()
	_G.null_ls_formatting_enabled = not _G.null_ls_formatting_enabled
	print("null-ls formatting " .. (_G.null_ls_formatting_enabled and "enabled" or "disabled"))
end

local function setup_null_ls()
	local null_ls = require("null-ls")
	local b = null_ls.builtins
	local cpplint = require("none-ls.diagnostics.cpplint")
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	vim.api.nvim_create_user_command("ToggleFormat", ToggleNullLsFormatting, {})

	local sources = {
		b.formatting.stylua,
		b.formatting.qmlformat,
		b.formatting.clang_format.with({
			extra_args = {
				"-style={BasedOnStyle: LLVM, AccessModifierOffset: -4, BreakConstructorInitializers: BeforeComma, IndentWidth: 4, ColumnLimit: 80, AlwaysBreakTemplateDeclarations: Yes, DerivePointerAlignment: false, PointerAlignment: Left, AlignEscapedNewlines: Right, AllowShortFunctionsOnASingleLine: Empty}",
			},
		}),

		b.formatting.gofumpt,
		b.formatting.goimports_reviser,
		b.formatting.golines,
		b.formatting.black,
		b.formatting.prettier.with({
			filetypes = {
				"css",
				"html",
				"javascript",
				"typescript",
				"json",
				"yaml",
				"markdown",
				"xaml",
			},
		}),

		cpplint,

		-- b.diagnostics.oxlint,
		-- b.diagnostics.cpplint,
		-- b.diagnostics.ruff,
	}

	null_ls.setup({
		debug = true,
		sources = sources,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				print("Formatting with: " .. client.name)
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						if not _G.null_ls_formatting_enabled then
							return
						end

						vim.lsp.buf.format({
							async = false,
							filter = function(c)
								return c.name == "null-ls"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
end

local function build_gopher()
	vim.cmd([[silent! GoInstallDeps]])
end

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = setup_mason,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		config = setup_lsp,
		event = "VeryLazy",
	},
	{
		"nvimtools/none-ls.nvim",
		config = setup_null_ls,
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls-extras.nvim" },
		event = "VeryLazy",
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		opts = {},
		build = build_gopher,
	},
	{
		"Civitasv/cmake-tools.nvim",
		ft = "cpp",
		opts = {
			cmake_executor = {
				name = "toggleterm",
				opts = {
					direction = "float",
					close_on_exit = false,
					auto_scroll = true,
				},
			},

			cmake_runner = {
				name = "toggleterm",
				opts = {
					direction = "float",
					close_on_exit = false,
					singleton = true,
				},
			},
		},
		lazy = true,
	},
}
