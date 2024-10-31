vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

return {
	"hrsh7th/nvim-cmp",
	opts = function()
		local lspkind = require("lspkind")
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
				-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- `true` to auto select first item. `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{
					{ name = "buffer" },
				},
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					with_text = true,
					ellipsis_char = "...",
					show_labelDetails = true,
					maxwidth = function()
						return math.floor(0.45 * vim.o.columns)
					end,
				}),
			},
		})
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{

			"onsails/lspkind.nvim",
			config = function()
				local lspkind = require("lspkind")
				lspkind.init({
					symbol_map = {
						Copilot = "",
					},
				})
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
			},
		},
	},
}
