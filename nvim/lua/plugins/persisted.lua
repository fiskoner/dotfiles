-- lua/plugins/persistence.lua
return {
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    opts = {
      save_dir = vim.fn.stdpath("data") .. "/sessions/", -- Directory where session files are saved
      autostart = true, -- Automatically start recording a session when Neovim starts
      autoload = false, -- Don't auto-load session for the dir on startup
      use_git_branch = true, -- Create session files per git branch
      follow_cwd = true, -- Change session file when the cwd changes
      
      -- Function to determine if a session should be saved
      should_save = function()
        return true
      end,
      
      -- Ignored filetypes
      telescope = {
        -- Telescope mappings
        mappings = {
          copy_session = "<C-c>",
          change_branch = "<C-b>",
          delete_session = "<C-d>",
        },
      },
    },
    config = function(_, opts)
      local status_ok, persisted = pcall(require, "persisted")
      if not status_ok then
        vim.notify("persisted.nvim not found!", vim.log.levels.WARN)
        return
      end
      
      -- Exclude CodeCompanion buffers from sessions
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePre",
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(buf)
            if string.match(name, "%[CodeCompanion%].*") then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
      
      -- Handle swap files automatically
      vim.api.nvim_create_autocmd("SwapExists", {
        callback = function()
          vim.v.swapchoice = 'e'  -- Edit anyway (ignores the swap file)
        end
      })
      
      -- Create autocommand to close empty buffers after session load
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedLoadPost",
        callback = function()
          vim.defer_fn(function()
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(bufnr) and 
                 vim.api.nvim_buf_get_name(bufnr) == "" and
                 vim.api.nvim_buf_line_count(bufnr) <= 1 then
                vim.api.nvim_buf_delete(bufnr, { force = true })
              end
            end
          end, 10)
        end,
      })
      
      persisted.setup(opts)
      
      -- Load the Telescope extension
      require("telescope").load_extension("persisted")
    end,
  },
}
