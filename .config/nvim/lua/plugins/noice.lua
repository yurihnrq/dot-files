return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI
			view = "cmdline", -- the view to use for the cmdline UI
		},
		messages = {
			enabled = true, -- enables the Noice messages UI
			view = "mini", -- the view to use for the messages UI
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
		},
		views = {
			mini = {
				align = "message-left",
				position = {
					row = -1,
					col = 0,
				},
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				render = "wrapped-compact",
				stages = "static",
				timeout = 2000,
				max_width = 50,
			},
		},
	},
}
