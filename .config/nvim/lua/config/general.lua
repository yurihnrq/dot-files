-- Add line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Remove mouse warning in popup menu
vim.api.nvim_command [[aunmenu PopUp.How-to\ disable\ mouse]]
vim.api.nvim_command [[aunmenu PopUp.-1-]]

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
