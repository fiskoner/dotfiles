-- ╭──────────────────────────────────────────────────────────╮
-- │  init.lua  ·  minimal bootstrap for lazy.nvim           │
-- ╰──────────────────────────────────────────────────────────╯

vim.g.mapleader = " "           -- <Space>
vim.g.maplocalleader = ","      -- local leader

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },   
  ui = { border = "rounded" }, 
})

vim.opt.number = true

-- Enable system clipboard integration across Linux, macOS, and Windows.
vim.opt.clipboard = "unnamedplus"

require("keymaps")
