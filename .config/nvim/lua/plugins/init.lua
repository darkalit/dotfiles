local plugins = {
	{},
}

require("lazy").setup({
	spec = {
		{ import = "plugins.colorscheme" },
		{ import = "plugins.telescope" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.undotree" },
		{ import = "plugins.color_highlighter" },
		{ import = "plugins.lsp" },
		{ import = "plugins.completion" },
		{ import = "plugins.nvimdev" },
		{ import = "plugins.filetree" },
		{ import = "plugins.ui" },
		{ import = "plugins.misc" },
		{ import = "plugins.debugger" },
		{ import = "plugins.dashboard" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true, notify = false },
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
