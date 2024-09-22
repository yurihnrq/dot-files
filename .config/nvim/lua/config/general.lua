-- Add line numbers
vim.wo.number = true
vim.wo.relativenumber = true

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
