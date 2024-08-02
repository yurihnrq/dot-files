return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- For lua install lua-language-server(https://luals.github.io/#neovim-install)
			lspconfig.lua_ls.setup({})
			-- For go install see gopls (https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-install)
			lspconfig.gopls.setup({})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				publish_diagnostic_on = "change",
				tsserver_plugins = {
					-- for TypeScript v4.9+
					-- "@styled/typescript-styled-plugin",
					-- or for older TypeScript versions
					"typescript-styled-plugin",
				},
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
