-- Use telescope with Ctrl+p
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", {noremap = true, silent = true})

return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
    		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        {"nvim-telescope/telescope.nvim", tag = "0.1.6"},
}
