-- lua/keymaps.lua
local opts = { noremap = true, silent = true }


-- ------- CodeCompanion Keymaps -------
require("codecompanion").setup()

-- Inline Assistant: invoke CodeCompanion (inline mode) in normal or visual
vim.keymap.set({"n", "v"}, "<localleader>cp", "<cmd>CodeCompanion<cr>", opts)

-- Chat Buffer: toggle CodeCompanionChat
vim.keymap.set({"n", "v"}, "<localleader>cc", "<cmd>CodeCompanionChat Toggle<cr>", opts)

-- Chat Buffer: open CodeCompanionChat (send prompt immediately if given)
vim.keymap.set("n", "<localleader>cC", "<cmd>CodeCompanionChat<cr>", opts)

-- Chat Buffer: add selected visual selection to chat
vim.keymap.set("v", "<localleader>ca", "<cmd>CodeCompanionChat Add<cr>", opts)

-- Action Palette: open CodeCompanionActions
vim.keymap.set({"n", "v"}, "<localleader>cA", "<cmd>CodeCompanionActions<cr>", opts)


return {}  -- module export placeholder

