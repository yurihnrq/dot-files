return {
	"mhartington/formatter.nvim",
	config = function()
		-- Config formatters per filetype using built in configs from formatter plugin
		local util = require("formatter.util")
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				javascript = {
					require("formatter.filetypes.javascript").eslint_d,
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").eslint_d,
				},
				typescript = {
					require("formatter.filetypes.typescript").eslint_d,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").eslint_d,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
				},
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				cpp = {
					require("formatter.filetypes.cpp").clangformat,
				},
				python = {
					require("formatter.filetypes.python").ruff,
				},
			},
		})

		-- Format code on write (:w)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
