local function set_indents(width, expandtab)
	return function()
		vim.bo.tabstop = width
		vim.bo.shiftwidth = width
		vim.bo.softtabstop = width
		vim.bo.expandtab = expandtab
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "html", "css", "json", "yaml" },
	callback = set_indents(2, true),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = set_indents(4, false),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "python" },
	callback = set_indents(4, true),
})
