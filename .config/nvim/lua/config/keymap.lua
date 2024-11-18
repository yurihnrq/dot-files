-- Rename using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
-- Rename using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-r>", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

-- Go to definition using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- Go to definition using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})

-- Command mode mappings
vim.api.nvim_set_keymap("c", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("c", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("c", "<C-l>", "<Right>", {})
