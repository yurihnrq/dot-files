-- Highlight current line
vim.opt.cursorline = true

-- Add line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Remove line numbers on TermOpen and add again on TermClose
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__term__", { clear = true })
autocmd("TermOpen", {
	group = "__term__",
	command = "setlocal nonumber norelativenumber",
})
autocmd("TermClose", {
	group = "__term__",
	command = "setlocal number relativenumber",
})

-- Change tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Remove mouse warning in popup menu
vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.api.nvim_command([[aunmenu PopUp.-1-]])

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
