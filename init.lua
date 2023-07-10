return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    setup_handlers = {
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
      jdtls = function(_, opts)
        vim.api.nvim_create_autocmd("Filetype", {
          pattern = "java", -- autocmd to start jdtls
          callback = function()
            if opts.root_dir and opts.root_dir ~= "" then require("jdtls").start_or_attach(opts) end
          end,
        })
      end,
      -- clangd = function(_, opts) require("clangd_extensions").setup { server = opts } end,
    },
    config = {
      -- clangd = {
      --   capabilities = {
      --     offsetEncoding = "utf-8",
      --     -- indentWidth = 4,
      --   },
      -- },
      -- set jdtls server settings
      -- jdtls = function()
      --   -- use this function notation to build some variables
      --   local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      --   local root_dir = require("jdtls.setup").find_root(root_markers)
      --
      --   -- calculate workspace dir
      --   local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      --   local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      --   os.execute("mkdir " .. workspace_dir)
      --
      --   -- get the mason install path
      --   local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      --
      --   -- get the current OS
      --   local os
      --   if vim.fn.has "macunix" then
      --     os = "mac"
      --   elseif vim.fn.has "win32" then
      --     os = "win"
      --   else
      --     os = "linux"
      --   end
      --
      --   -- return the server config
      --   return {
      --     cmd = {
      --       "java",
      --       "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      --       "-Dosgi.bundles.defaultStartLevel=4",
      --       "-Declipse.product=org.eclipse.jdt.ls.core.product",
      --       "-Dlog.protocol=true",
      --       "-Dlog.level=ALL",
      --       "-javaagent:" .. install_path .. "/lombok.jar",
      --       "-Xms1g",
      --       "--add-modules=ALL-SYSTEM",
      --       "--add-opens",
      --       "java.base/java.util=ALL-UNNAMED",
      --       "--add-opens",
      --       "java.base/java.lang=ALL-UNNAMED",
      --       "-jar",
      --       vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
      --       "-configuration",
      --       install_path .. "/config_" .. os,
      --       "-data",
      --       workspace_dir,
      --     },
      --     root_dir = root_dir,
      --   }
      -- end,
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  plugins = {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" }, -- automatically install lsp
      },
    },
    "simrat39/rust-tools.nvim", -- add lsp plugin
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "rust_analyzer" },
      },
    },
    "mfussenegger/nvim-jdtls", -- load jdtls on module
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "jdtls" },
      },
    },
    "phaazon/hop.nvim",
    {
      branch = "v2",
      opts = {},
      config = function() require("hop").setup {} end,
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
