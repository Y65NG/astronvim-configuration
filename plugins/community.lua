return { -- Add the community repository of plugin specifications
"AstroNvim/astrocommunity", {
    import = "astrocommunity.motion.hop-nvim"
}, {
    "phaazon/hop.nvim",
    -- "hop-nvim",
    opts = {},
    keys = {{
        "s",
        function()
            require("hop").hint_words()
        end,
        mode = {"n"},
        desc = "Hop hint words"
    }, {
        "<S-s>",
        function()
            require("hop").hint_vertical()
        end,
        mode = {"n"},
        desc = "Hop hint lines"
    }, -- {
    --   "<S-s>",
    --   function()
    --     require("hop").hint_char1 {
    --       direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    --       current_line_only = false,
    --     }
    --   end,
    --   mode = { "n" },
    --   desc = "Hop hint lines",
    -- },
    {
        "s",
        function()
            require("hop").hint_words {
                extend_visual = true
            }
        end,
        mode = {"v"},
        desc = "Hop hint words"
    }, {
        "<S-s>",
        function()
            require("hop").hint_vertical {
                extend_visual = true
            }
        end,
        mode = {"v"},
        desc = "Hop hint lines"
    }}
}, {
    import = "shaunsingh/nord.nvim",
    enabled = false
}, {
    "shaunsingh/nord.nvim",
    init = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = false
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false
    end
}, {
    "lukas-reineke/headlines.nvim",
    optional = true,
    opts = {
        markdown = {
            headline_highlights = {"Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6"}
        }
    }
}, {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
        return require("astronvim.utils").extend_tbl(opts, {
            highlights = require("nord").bufferline.highlights {
                italic = true,
                bold = true
            },
            options = {
                separator_style = "thin"
            }
        })
    end
}, {
    import = "sainnhe/everforest",
    enabled = false
}, {"sainnhe/everforest"}, -- {
--     import = "projekt0n/github-nvim-theme"
-- }, 
{"projekt0n/github-nvim-theme"}, -- example of imporing a plugin, comment out to use it or add your own
-- available plugins can be found at https://github.com/AstroNvim/astrocommunity
-- { import = "astrocommunity.colorscheme.catppuccin" },
-- { import = "astrocommunity.completion.copilot-lua-cmp" },
{
    "lvimuser/lsp-inlayhints.nvim",
    init = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.inlayHintProvider then
                    local inlayhints = require "lsp-inlayhints"
                    inlayhints.on_attach(client, args.buf)
                    require("astronvim.utils").set_mappings({
                        n = {
                            ["<leader>uH"] = {
                                inlayhints.toggle,
                                desc = "Toggle inlay hints"
                            }
                        }
                    }, {
                        buffer = args.buf
                    })
                end
            end
        })
    end,
    opts = {}
}, {
    "p00f/clangd_extensions.nvim",
    optional = true,
    opts = {
        extensions = {
            autoSetHints = false
        }
    }
}, {
    "simrat39/rust-tools.nvim",
    optional = true,
    opts = {
        tools = {
            inlay_hints = {
                auto = false
            }
        }
    }
}}
