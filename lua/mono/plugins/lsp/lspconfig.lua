return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'saghen/blink.cmp',
        "williamboman/mason-lspconfig.nvim",
        {
            "folke/lazydev.nvim",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local map = vim.keymap

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "lua_ls", "clangd", "csharp_ls", --[["tsserver",]]
                "rust_analyzer", "elixirls", "pyright",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Show LSP references"
                map.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                map.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                map.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                map.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                map.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                -- opts.desc = "Smart rename"
                -- map.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                map.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                map.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Show documentation for what is under cursor"
                map.set("n", "Q", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                map.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- Manually set up each LSP server with capabilities
        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server)
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = function()
                        -- Additional on_attach logic can go here if needed
                    end,
                })
            end,
            ["clangd"] = function()
                lspconfig["clangd"].setup({
                    capabilities = capabilities,
                    cmd = { "clangd", "--compile-commands-dir=build" },
                    filetype = { "c", "cpp" },
                })
            end,
            ["csharp_ls"] = function()
                lspconfig["csharp_ls"].setup({
                    capabilities = capabilities,
                })
            end,
            ["pyright"] = function()
                lspconfig["pyright"].setup({
                    capabilities = capabilities,
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "strict",      -- Options: off, basic, strict
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly", -- Options: openFilesOnly, workspace
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                })
            end,

            ["rust_analyzer"] = function()
                lspconfig.rust_analyzer.setup({
                    capabilities = capabilities,
                })
            end,
            ["elixirls"] = function()
                lspconfig["elixirls"].setup({
                    cmd = { "elixir-ls" },
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["lua_ls"] = function()
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
