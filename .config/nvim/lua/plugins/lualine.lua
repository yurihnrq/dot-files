-- Use one statusline globally
vim.opt.laststatus = 3
-- Hide cmd line
vim.opt.cmdheight = 0

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			global_status = true,
			disabled_filetypes = { "NvimTree", "neo-tree" },
		},
	},
}
