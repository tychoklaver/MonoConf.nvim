return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- See the full "keymap" documentation for information on defining your own keymap.
        keymap = {
            ['<C-k>'] = { 'select_prev' },
            ['<C-j>'] = { 'select_next' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-q>'] = { 'show_documentation', 'hide_documentation' },
            ['<M-k>'] = {
                function(cmp)
                    cmp.scroll_documentation_up(4)
                end, "fallback"
            },
            ['<M-j>'] = {
                function(cmp)
                    cmp.scroll_documentation_down(4)
                end, "fallback"
            },
        },
        cmdline = {
            keymap = {
                ['<CR>'] = { },
                ['<C-k>'] = { 'select_prev' },
                ['<C-j>'] = { 'select_next' },
                ['<C-y>'] = { 'accept', 'fallback' },
            }
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 50,
                window = {
                    border = vim.g.border_style
                }
            },
            ghost_text = {
                enabled = false
            },
            accept = {
                auto_brackets = {
                    enabled = true
                },
            },
            menu = {
                border = vim.g.border_style,
                scrolloff = 1,
                scrollbar = false,
                draw = {
                    columns = {
                        { "kind_icon", "label", gap = 1 },
                        { "kind" }
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local lspkind = require("lspkind")
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,

                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = "BlinkCmpKind" .. ctx.kind
                                or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        }
                    }
                }
            },
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lsp = {
                    name = "LSP",
                    module = "blink.cmp.sources.lsp"
                },
            },
        },
    },
    opts_extend = { "sources.default" }
}
