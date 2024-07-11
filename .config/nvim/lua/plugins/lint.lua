return {
    "mfussenegger/nvim-lint",
    config = function()
        -- Config linters per filetype
        require("lint").linters_by_ft = {
            typescript = {"eslint_d"},
            javascript = {"eslint_d"},
            typescriptreact = {"eslint_d"},
            javascriptreact = {"eslint_d"}
        }

        -- Config to run linters on open file, leave insert mode and modify text
        vim.api.nvim_create_autocmd(
            {"BufReadPost", "InsertLeave", "TextChanged"},
            {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    require("lint").try_lint()
                end
            }
        )
    end
}

