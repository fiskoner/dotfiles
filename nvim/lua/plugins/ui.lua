-- lua/plugins/ui.lua

return {
  -- which-key to display keys
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

  -- lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "BufWinEnter",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto", -- you can change this to any theme you want
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {"location"}
        },
        extensions = {}
      })
    end,
  },

  -- Monokai Pro theme
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      transparent_background = false,
      terminal_colors       = true,
      devicons              = true,
      filter = "pro",
      day_night = {
        enable       = false,
        day_filter   = "pro",
        night_filter = "spectrum",
      },
      styles = {
        comment       = { italic = true },
        keyword       = { italic = true },
        type          = { italic = true },
        storageclass  = { italic = true },
        structure     = { italic = true },
        parameter     = { italic = true },
        annotation    = { italic = true },
        tag_attribute = { italic = true },
      },
      inc_search = "background",
      background_clear = {
        "telescope",
        "toggleterm",
        "neo-tree",
        "notify",
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible  = false,
        },
        indent_blankline = {
          context_highlight       = "default",
          context_start_underline = false,
        },
      },
      override = function(c) end,
      overrideScheme = function(cs, p, cfg, hp) end,
    },
    config = function(_, opts)
      require("monokai-pro").setup(opts)
      vim.cmd.colorscheme("monokai-pro")
    end,
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },
      constrain_cursor = "editable",
      watch_for_changes = false,
      keymaps = {
        ["g?"]   = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"]     = { "actions.parent", mode = "n" },
        ["_"]     = { "actions.open_cwd", mode = "n" },
        ["`"]     = { "actions.cd", mode = "n" },
        ["~"]     = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"]    = { "actions.change_sort", mode = "n" },
        ["gx"]    = "actions.open_external",
        ["g."]    = { "actions.toggle_hidden", mode = "n" },
        ["g\\"]  = { "actions.toggle_trash", mode = "n" },
      },
      use_default_keymaps = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          local m = name:match("^%.")
          return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },
      extra_scp_args = {},
      git = {
        add = function(path)
          return false
        end,
        mv = function(src_path, dest_path)
          return false
        end,
        rm = function(path)
          return false
        end,
      },
      float = {
        padding = 5,
        max_width = 0.6,
        max_height = 0.6,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        get_win_title = nil,
        preview_split = "auto",
        override = function(conf)
          return conf
        end,
      },
      preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
        disable_preview = function(filename)
          return false
        end,
        win_options = {},
      },
      confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      ssh = {
        border = "rounded",
      },
      keymaps_help = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
  
  {
    "akinsho/nvim-bufferline.lua",
    event = "BufWinEnter",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          numbers = "none",
          indicator = {
            icon = "▎",
            style = "icon",
          },
	  max_name_length = 20,
	  truncate_names = true,
	  tab_size = 20,
          buffer_close_icon = "x",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
	  show_buffer_icons = false,
	  show_buffer_close_icons = false,
	  show_close_icon = false,
	  show_tab_indicators = false,
	  show_duplicate_prefix = true,
	  separator_style = "thin",
	  enforce_regular_tabs = false,
	  always_show_bufferline = true,
        },
      })
    end,
  }

}
