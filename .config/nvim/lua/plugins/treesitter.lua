local function setup()
	local config = require("nvim-treesitter.config")

	config.setup({
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"cpp",
			"qmljs",
			"cmake",
			"go",
			"gomod",
			"gosum",
			"gotmpl",
			"json",
			"html",
			"css",
			"javascript",
			"yaml",
			"typescript",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	})
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = setup,
	},
}
