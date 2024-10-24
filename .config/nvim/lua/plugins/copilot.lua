-- Toggle Copilot Chat with ' cp'
vim.api.nvim_set_keymap("n", "<leader>cp", ":CopilotChatToggle<CR>", { noremap = true, silent = true })

return {
	{

		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				config = function()
					require("copilot").setup({})
				end,
			},
			"nvim-lua/plenary.nvim", -- for curl, log wrapper
		},
		opts = {
			window = {
				layout = "float",
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
