-- lua/plugins/lsp.lua
-- Python LSP stack using **BasedPyright** + Ruff and some convenient
-- key‑maps that mirror typical IDE shortcuts.  Drop this in
-- `lua/plugins/`, `:Lazy sync`, then reopen a Python file.

return {
  -- 1. mason.nvim – downloads external tools (pip‑style) ---------------------
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    opts = {},
  },

  -- 2. mason‑lspconfig – bridge Mason ↔︎ lspconfig ---------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "basedpyright", "ruff" },
      automatic_installation = true,
    },
  },

  -- 3. nvim‑lspconfig – wire LSPs into buffers ------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim", -- for :Telescope lsp_* pickers
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")

      -----------------------------------------------------------------------
      -- on_attach: add key‑maps when LSP attaches to a buffer
      -----------------------------------------------------------------------
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = desc })
        end

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gd", vim.lsp.buf.definition, "Goto Definition")
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
        nmap("gr", require("telescope.builtin").lsp_references, "References")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        nmap("<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format File")
      end

      -----------------------------------------------------------------------
      -- Mason handlers: configure each server
      -----------------------------------------------------------------------
      mason_lsp.setup_handlers({
        -- disable vanilla Pyright – we only want BasedPyright
        ["pyright"] = function() end,

        -- BasedPyright – main Python LS
        ["basedpyright"] = function()
          lspconfig.basedpyright.setup({
            on_attach = on_attach,
            settings = {
              basedpyright = {
                typeCheckingMode = "standard", -- off | basic | standard | strict
                diagnosticMode = "workspace",
              },
            },
          })
        end,

        -- Ruff – linter/formatter LS
        ["ruff"] = function()
          lspconfig.ruff.setup({
            on_attach = on_attach,
            init_options = {
              settings = { args = {} },
            },
          })
        end,

        -- fallback – any other future servers
        function(server_name)
          lspconfig[server_name].setup({ on_attach = on_attach })
        end,
      })
    end,
  },
}

