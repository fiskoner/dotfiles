-- lua/plugins/lsp.lua
local lsp_keymaps = require("keymaps").lsp_keymaps
local util

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
end

-- Generic setup helper
local function default_setup(server)
  require("lspconfig")[server].setup({
    on_attach = on_attach,
    root_dir  = util.root_pattern(
      "pyrightconfig.json",
      "pyproject.toml",
      "setup.cfg",
      "requirements.txt",
      "main.py",
      "app.py",
      ".git"
    ),
  })
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "basedpyright", "ruff" },
      automatic_installation = true,
    },
  },
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
      util = require("lspconfig.util")  -- Fix the util variable assignment
      
      -- Make sure to call setup before setup_handlers
      mason_lsp.setup({
        ensure_installed = { "basedpyright", "ruff" },
        automatic_installation = true,
      })

      mason_lsp.setup_handlers({
        -- disable vanilla Pyright – i only need BasedPyright
        ["pyright"] = function() end,
        ["basedpyright"] = function()
          lspconfig.basedpyright.setup({
            on_attach = on_attach,
            root_dir  = util.root_pattern(
              "pyrightconfig.json",
              "pyproject.toml",
              "setup.cfg",
              "requirements.txt",
              ".git"
            ),
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "standard", -- off | basic | standard | strict
                  diagnosticMode = "workspace",
                  indexing = true,
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  autoImportCompletions = true,
                },
              },
            },
          })
        end,
        ["ruff"] = function()
          lspconfig.ruff.setup({
            on_attach = on_attach,
            init_options = {
              settings = { args = {} },
            },
          })
        end,
        -- fallback for any other server:
        default_setup,
      })
    end,
  },
}
