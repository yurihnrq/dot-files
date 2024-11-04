-- Use telescope with shortcuts
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fr", ":Telescope resume<CR>", { noremap = true, silent = true })


return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						width = 0.87,
						height = 0.80,
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("noice")

			-- Wrap lines in previewer
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopePreviewerLoaded",
				callback = function()
					vim.wo.wrap = true
				end,
			})
		end,
	},
}
