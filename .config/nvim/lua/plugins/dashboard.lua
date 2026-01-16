local function setup()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		"                                                    ..                         ",
		"                                                   ..:....                     ",
		"                                                   ....-:..                    ",
		"                                                 ..:.:@@=...                   ",
		"                                             ......:@@@@@@:...                 ",
		"                                         ..........:@@@@@@..........           ",
		"                                       ...:=::.=@-@@@@@@@@@@:@-....=..         ",
		"                                     .....:@@@@@@@@@@@@@@@@@@@@@#@@=:.         ",
		"                                  ......::-@@@@@@@@@@@@@@@@@@@@@@@-....        ",
		"                      ..:...............:#@@@@@@@@@@@@@@@@@@@@@@@@@-...        ",
		"                      ..=::*..::.:.....-@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:..       ",
		"                     ....:+@@@@@@@=:::#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=:.        ",
		"                   .....:@@@@@@@@@@@@-#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*..        ",
		"            .........+---@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=..         ",
		"     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-....         ",
		"            .........+---@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=..         ",
		"                   .....:@@@@@@@@@@@@-#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*..        ",
		"                     ....:+@@@@@@@=:::#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=:.        ",
		"                      ..=::*..::.:.....-@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:..       ",
		"                      ..:...............:#@@@@@@@@@@@@@@@@@@@@@@@@@-...        ",
		"                                  ......::-@@@@@@@@@@@@@@@@@@@@@@@-....        ",
		"                                     .....:@@@@@@@@@@@@@@@@@@@@@#@@=:.         ",
		"                                       ...:=::.=@-@@@@@@@@@@:@-....=..         ",
		"                                         ..........:@@@@@@..........           ",
		"                                             ......:@@@@@@:...                 ",
		"                                                 ..:.:@@=...                   ",
		"                                                   ....-:..                    ",
		"                                                   ..:....                     ",
		"                                                    ..                         ",
	}

	dashboard.section.buttons.val = {}

	local function footer()
		local num_plugins_loaded = require("lazy").stats().count
		local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
		local version = vim.version()
		local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

		return {
			"'If you aren't sure which way to do something, do it both ways and see which works better.' ~ John Carmack",
			"",
			datetime .. "   " .. num_plugins_loaded .. " plugins" .. nvim_version_info,
		}
	end
	dashboard.section.footer.val = footer()
	dashboard.section.footer.opts = {
		position = "center",
	}
	dashboard.section.footer.opts.hl = "Constant"

	alpha.setup(dashboard.opts)
	vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
end

return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = setup,
	},
}
