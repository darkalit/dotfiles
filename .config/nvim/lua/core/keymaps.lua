local keymap = vim.keymap.set

-- [[ Utility remaps ]]
-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Append line below to the end without moving cursor
keymap("n", "J", "mzJ`z")

-- Half page jump but center to cursor
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Keep search items in the middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Keep paste info on pasting over selection
keymap("x", "<leader>p", '"_dP')

-- idk
keymap("n", "Q", "<nop>")

-- [[ Telescope remaps ]]
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- [[ Plugins remaps ]]
-- File tree
keymap("n", "<C-n>", "<cmd>Neotree toggle<CR>")

-- Terminal
keymap("t", "<esc>", "<C-\\><C-n>")
keymap("n", [[<C-\>]], "<cmd>ToggleTerm direction=float<CR>")

-- Comments
keymap("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
keymap("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")
keymap("n", "<C-b>", "<Plug>(comment_toggle_blockwise_current)")
keymap("v", "<C-b>", "<Plug>(comment_toggle_blockwise_visual)")

-- Header/Source switch
keymap("n", "F", "<cmd>FSHere<CR>")

-- Lsp config
keymap("n", "L", function()
	vim.diagnostic.open_float()
end)
keymap("n", "gD", function()
	vim.lsp.buf.definition()
end)
keymap("n", "gd", function()
	vim.lsp.buf.definition()
end)
keymap("n", "K", function()
	vim.lsp.buf.hover()
end)
keymap("n", "gi", function()
	vim.lsp.buf.implementation()
end)
keymap("n", "<leader>ls", function()
	vim.lsp.buf.signature_help()
end)
keymap("n", "<leader>D", function()
	vim.lsp.buf.type_definition()
end)
keymap("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
keymap("n", "gr", function()
	vim.lsp.buf.references()
end)
keymap("v", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
