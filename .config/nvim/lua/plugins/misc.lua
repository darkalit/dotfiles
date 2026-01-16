return {
	{
		"wurli/visimatch.nvim",
		event = "VeryLazy",
		opts = {
			chars_lower_limit = 4,
		},
	},
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		opts = {
			neovim_image_text = "ITS A FUCKING NEOVIM",
			main_image = "file",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm i",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MagicDuck/grug-far.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"derekwyatt/vim-fswitch",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.cpp", "*.cxx", "*.cc" },
				callback = function()
					vim.b.fswitchdst = "hpp,hh,h"
					vim.b.fswitchlocs = "reg:|Source|Include|,reg:|source|include|,../Include,../include"
				end,
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.hpp", "*.h" },
				callback = function()
					vim.b.fswitchdst = "cpp,cc,cxx"
					vim.b.fswitchlocs = "reg:|Include|Source|,reg:|include|source|,../Source,../source"
				end,
			})

			-- vim.g.fsnonewfiles = 1
		end,
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
}
