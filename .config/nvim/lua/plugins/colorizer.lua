return {
	"norcalli/nvim-colorizer.lua",
	opts = {},
	config = function()
		-- Attach on BufEnter
		vim.api.nvim_command([[autocmd BufEnter * ColorizerAttachToBuffer]])
	end,
}
