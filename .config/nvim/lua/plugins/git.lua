vim.api.nvim_set_keymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true })

return {
	"lewis6991/gitsigns.nvim",
	opts = {},
}
