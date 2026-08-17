require("lazydev").setup()

vim.lsp.config("tsc", {
	settings = {
		typescript = {
			preferences = { importModuleSpecifierPreference = "non-relative" },
		},
	},
})

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("oxlint", {
	settings = {
		typeAware = false,
	},
})

vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "tw", "twMerge", "tv", "clsx" },
		},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = require("schemastore").yaml.schemas(),
			redhat = { telemetry = { enabled = false } },
		},
	},
})

vim.lsp.enable({
	"golangci_lint_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"oxfmt",
	"oxlint",
	"prismals",
	"pyright",
	"ruff",
	"sqruff",
	"tailwindcss",
	"tsc",
	"yamlls",
})
