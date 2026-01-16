local function setup()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			layout_config = {
				horizontal = { preview_width = 0.55 },
				vertical = { mirror = false },
			},
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})
	telescope.load_extension("fzf")
end

local function build_fzf(plugin)
	local plugin_dir = plugin.dir
	local build_dir = plugin_dir .. "/build"

	-- Windows moment
	if vim.fn.has("win32") == 1 then
		vim.fn.system({
			"cmake",
			"-S",
			plugin_dir,
			"-B",
			build_dir,
			"-DCMAKE_BUILD_TYPE=Release",
			"-DCMAKE_POLICY_VERSION_MINIMUM='3.5'",
		})
		vim.fn.system({ "cmake", "--build", build_dir, "--config", "Release" })

		local dll_src = (build_dir .. "/Release/libfzf.dll"):gsub("/", "\\")
		local dll_dst = (build_dir .. "/libfzf.dll"):gsub("/", "\\")
		if vim.fn.filereadable(dll_src) == 1 then
			vim.fn.system({ "cmd", "/C", "copy", dll_src, dll_dst })
		end
	else
		vim.fn.system({ "cmake", "-S", plugin_dir, "-B", build_dir, "-DCMAKE_BUILD_TYPE=Release" })
		vim.fn.system({ "cmake", "--build", build_dir, "--config", "Release" })
		vim.fn.system({ "cmake", "--install", build_dir, "--prefix", "build" })
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = build_fzf },
		},
		config = setup,
		cmd = "Telescope",
	},
}
