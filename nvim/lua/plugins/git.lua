return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" }, -- Loads when Git or G commands are used
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead", -- Load on file open
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Neogit" },
    config = function()
      require("neogit").setup {}
    end,
  },
}
