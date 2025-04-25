-- lua/plugins/lsp.lua
-- Python LSP stack using **BasedPyright** (instead of Pyright) + Ruff
-- This file is read by Lazy‑nvim.  Drop it in `lua/plugins/` and commit.
-- After saving, run :Lazy sync, then reopen a *.py buffer.

return {
  ----------------------------------------------------------------------------
  -- 1. mason.nvim – downloads external tools (pip‑style)
  ----------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    lazy = false,               -- start at Neovim launch so tools exist early
    build = ":MasonUpdate",     -- optional: keep Mason registry fresh
    opts = {},
  },

  ----------------------------------------------------------------------------
  -- 2. mason‑lspconfig – ask Mason for the servers we care about
  ----------------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "basedpyright",   -- type checker / language server (fork of Pyright)
        "ruff",           -- linter & formatter (ruff‑lsp)
      },
      automatic_installation = true,
    },
  },

  ----------------------------------------------------------------------------
  -- 3. nvim‑lspconfig – attach LSPs to buffers
  ----------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")

      mason_lsp.setup_handlers({
        -- Disable vanilla Pyright so we don’t get two servers fighting
        ["pyright"] = function() end,

        -- BasedPyright – main Python language server
        ["basedpyright"] = function()
          lspconfig.basedpyright.setup({
            settings = {
              basedpyright = {
                typeCheckingMode = "standard", -- off | basic | standard | strict
                diagnosticMode = "workspace",   -- or "openFilesOnly"
              },
            },
          })
        end,

        -- Ruff – linter/formatter
        ["ruff"] = function()
          lspconfig.ruff.setup({
            init_options = {
              settings = {
                args = {},
              },
            },
          })
        end,

        -- Fallback for any other servers you add later
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })
    end,
  },
}

