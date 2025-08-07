return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", -- JavaScript/TypeScript
          "gopls", -- Go
          "rust_analyzer", -- Rust
          "clangd", -- C/C++
          "lua_ls", -- Lua
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local servers = {
        "ts_ls", -- JavaScript/TypeScript
        "gopls", -- Go
        "rust_analyzer", -- Rust
        "clangd", -- C
        "lua_ls", -- Lua
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          settings = server == "lua_ls" and {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Recognize Vim globals
              },
            },
          } or {},
        })
      end
    end,
  },
  -- Optional: Add nvim-cmp for autocompletion (recommended)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
