-- lua/keymaps.lua
local opts = { noremap = true, silent = true }

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


-- ------- LSP Keymaps -------
local function lsp_keymaps(bufnr)
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
  nmap("<leader>gf", function()
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    vim.lsp.buf.format({ async = true })
  end, "Format File")
end


-- ------- Telescope Keymaps -------
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help tags" })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = "Search in all files" })
vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = "Search files by filename" })
vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = "Search workspace symbols" })
vim.keymap.set('n', '<leader>fd', builtin.lsp_document_symbols, { desc = "Search document symbols" })

-- Git: Fugitive commands (status, commit, push)
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = "Git Status" })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = "Git Commit" })
vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', { desc = "Git Pull" })
vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { desc = "Git Push" })

-- Git: Diffview commands for opening and closing diffs
vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = "Open Diffview" })
vim.keymap.set('n', '<leader>gD', ':DiffviewClose<CR>', { desc = "Close Diffview" })

-- Git: Neogit for a full interactive Git interface
vim.keymap.set('n', '<leader>gn', ':Neogit<CR>', { desc = "Neogit" })

-- Git: Gitsigns inline blame toggle for current line
vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = "Toggle Git Blame" })

-- ------- oil.nvim -------
vim.keymap.set("n", "<leader>oo", "<cmd>Oil<cr>", { noremap = true, silent = true, desc = "Open Oil file browser" })
vim.keymap.set("n", "<leader>of", "<cmd>Oil --float<cr>", { noremap = true, silent = true, desc = "Open floating Oil file browser" })

-- ------- Bufferline -------
-- Navigate to previous buffer
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
-- Navigate to next buffer
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })


-- -------  Keymaps -------
vim.keymap.set('i', '<localleader>cm', function() require("cmp").complete() end, { desc = "Trigger Completion", silent = true })


return {
  lsp_keymaps = lsp_keymaps, -- Export the LSP keymaps function
}
