-- Open neo-tree with Ctrl+b
vim.api.nvim_set_keymap("n", "<C-b>", ":Neotree<CR>", { noremap = true, silent = true })

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			opts = {
				override = {
					go = {
						icon = "󰟓",
						color = "#00add8",
						name = "go",
					},
					["go.mod"] = {
						icon = "󰟓",
						color = "#00add8",
						name = "go_mod",
					},
					["go.sum"] = {
						icon = "󰟓",
						color = "#00add8",
						name = "go_sum",
					},
					["go.work"] = {
						icon = "󰟓",
						color = "#00add8",
						name = "go_work",
					},
				},
			},
		},
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		hijack_netrw_behavior = "disabled",
		window = {
			position = "right",
			width = 40,
			mappings = {
				["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
				["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
			},
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
		},
	},
}
