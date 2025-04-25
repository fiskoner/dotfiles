-- lua/plugins/ui.lua

-- which key to display keys
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        plugins = { spelling = { enabled = true } },
      })
    end,
    opts = {
      plugins = { spelling = { enabled = true } },
      win = { border = "rounded" },
    }
  },

  -- nvim-web-devicons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- mini.icons
  { "echasnovski/mini.icons",
    version = "*",        -- always grab latest tag
    opts = {},            -- default config is fine
  },
}
