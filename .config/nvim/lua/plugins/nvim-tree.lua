-- Toggle Nvim Tree with Ctrl+b
vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

return {
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
                }
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			view = {
				side = "right",
				width = {
					min = "25%",
					max = "35%",
				},
			},
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = {
					enable = true,
				},
			},
			renderer = {
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "| ",
						item = "| ",
						none = "  ",
					},
				},
			},
		},
	},
}
