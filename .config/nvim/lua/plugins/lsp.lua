return {
    "neovim/nvim-lspconfig",
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
        opts = {
            settings = {
                publish_diagnostic_on = "change",
                tsserver_plugins = {
                    -- for TypeScript v4.9+
                    -- "@styled/typescript-styled-plugin",
                    -- or for older TypeScript versions
                    "typescript-styled-plugin"
                }
            }
        }
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua"
        },
        config = function()
            require("lsp-file-operations").setup()
        end
    }
}

