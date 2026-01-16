vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true

-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Global Indentations (for particular filetipe configs are in core.indents)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line wrap
vim.opt.wrap = false

-- Undo options
vim.opt.swapfile = false
vim.opt.backup = false
vim.undodir = vim.fn.stdpath("data") .. "/undo"
vim.undofile = true

-- Incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--
vim.opt.termguicolors = true

--
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Update time
vim.opt.updatetime = 50

--
vim.opt.colorcolumn = "80"
vim.o.winborder = "rounded"

--
vim.opt.fileformat = "unix"

require("core")
require("plugins")
