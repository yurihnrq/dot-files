local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Toggle Nvim Tree with Ctrl+b
vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
-- Use telescope with Ctrl+p
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", {noremap = true, silent = true})
-- Toggle Copilot Chat with Ctrl+c
vim.api.nvim_set_keymap("n", "<C-c>", ":CopilotChatToggle<CR>", {noremap = true, silent = true})

-- Rename using LSP in normal mode
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})
-- Rename using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-r>", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true})

-- Go to definition using LSP in normal mode
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
-- Go to definition using LSP in insert mode
vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})

-- Insert mode mappings
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})

-- Command mode mappings
vim.api.nvim_set_keymap("c", "<C-h>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-j>", "<Down>", {})
vim.api.nvim_set_keymap("c", "<C-k>", "<Up>", {})
vim.api.nvim_set_keymap("c", "<C-l>", "<Right>", {})

-- Add line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Remove mouse warning in popup menu
vim.api.nvim_command [[aunmenu PopUp.How-to\ disable\ mouse]]
vim.api.nvim_command [[aunmenu PopUp.-1-]]

-- Config clipboard for WSL
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe"
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        },
        cache_enabled = 0
    }
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        "github/copilot.vim",
        "nvim-tree/nvim-tree.lua",
        "natecraddock/workspaces.nvim",
        "nvim-lua/plenary.nvim",
        "navarasu/onedark.nvim",
        "mfussenegger/nvim-lint",
        "mhartington/formatter.nvim",
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "neovim/nvim-lspconfig",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = {
                        "saadparwaiz1/cmp_luasnip"
                    }
                }
            },
            opts = function()
                local cmp = require "cmp"

                cmp.setup(
                    {
                        snippet = {
                            -- REQUIRED - you must specify a snippet engine
                            expand = function(args)
                                require("luasnip").lsp_expand(args.body)
                            end
                        },
                        mapping = cmp.mapping.preset.insert(
                            {
                                -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                                ["<C-Space>"] = cmp.mapping.complete(),
                                ["<C-e>"] = cmp.mapping.abort(),
                                ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                            }
                        ),
                        sources = cmp.config.sources(
                            {
                                {name = "nvim_lsp"},
                                {name = "luasnip"}, -- For luasnip users.
                                {
                                    {name = "buffer"}
                                }
                            }
                        )
                    }
                )
            end
        },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "canary",
            dependencies = {
                {"zbirenbaum/copilot.lua"}, -- or github/copilot.vim
                {"nvim-lua/plenary.nvim"} -- for curl, log wrapper
            },
            opts = {
                debug = true -- Enable debugging
                -- See Configuration section for rest
            }
            -- See Commands section for default commands if you want to lazy load on them
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        {"nvim-telescope/telescope.nvim", tag = "0.1.6"},
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
            config = function()
                require("nvim-tree").setup {
                    view = {
                        side = "right",
                        width = {
                            min = "25%",
                            max = "35%"
                        }
                    },
                    sync_root_with_cwd = true,
                    update_focused_file = {
                        enable = true,
                        update_root = {
                            enable = true
                        }
                    },
                    renderer = {
                        indent_markers = {
                            enable = true,
                            icons = {
                                corner = "└ ",
                                edge = "| ",
                                item = "| ",
                                none = "  "
                            }
                        }
                    }
                }
            end
        },
        "neovim/nvim-lspconfig",
        {
            "pmizio/typescript-tools.nvim",
            dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
            opts = {}
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")
                configs.setup(
                    {
                        ensure_installed = {"c", "lua", "vim", "vimdoc", "go", "typescript", "javascript", "html"},
                        sync_install = false,
                        highlight = {enable = true},
                        indent = {enable = true}
                    }
                )
            end
        },
        {
            "lewis6991/hover.nvim",
            config = function()
                require("hover").setup {
                    init = function()
                        -- Require providers
                        require("hover.providers.lsp")
                        require("hover.providers.gh")
                        -- require('hover.providers.gh_user')
                        -- require('hover.providers.jira')
                        -- require('hover.providers.dap')
                        -- require('hover.providers.fold_preview')
                        require("hover.providers.diagnostic")
                        -- require('hover.providers.man')
                        -- require('hover.providers.dictionary')
                    end,
                    preview_opts = {
                        border = "single"
                    },
                    -- Whether the contents of a currently open hover window should be moved
                    -- to a :h preview-window when pressing the hover keymap.
                    preview_window = false,
                    title = true,
                    mouse_providers = {
                        "LSP"
                    },
                    mouse_delay = 1000
                }

                -- Setup keymaps
                vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
                vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})

                -- Mouse support
                vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, {desc = "hover.nvim (mouse)"})
                vim.o.mousemoveevent = true
            end
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equalent to setup({}) function
        },
        "windwp/nvim-ts-autotag",
        "dyng/ctrlsf.vim",
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
)
-- Load onedark theme
require("onedark").load()
-- Add hooks for workspaces plugin
require("workspaces").setup(
    {
        hooks = {
            open = {"NvimTreeOpen", "Telescope find_files"}
        }
    }
)
-- Publish code diagnostic for typescript code on change
require("typescript-tools").setup(
    {
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
)

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

-- Config formatters per filetype using built in configs from formatter plugin
local util = require "formatter.util"
require("formatter").setup(
    {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
            javascript = {
                require("formatter.filetypes.javascript").eslint_d
            },
            javascriptreact = {
                require("formatter.filetypes.javascriptreact").eslint_d
            },
            typescript = {
                require("formatter.filetypes.typescript").eslint_d
            },
            typescriptreact = {
                require("formatter.filetypes.typescriptreact").eslint_d
            },
            lua = {
                require("formatter.filetypes.lua").stylua
            },
            go = {
                require("formatter.filetypes.go").gofmt
            }
        }
    }
)

-- Format code on write (:w)
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", {clear = true})
autocmd(
    "BufWritePost",
    {
        group = "__formatter__",
        command = ":FormatWrite"
    }
)

