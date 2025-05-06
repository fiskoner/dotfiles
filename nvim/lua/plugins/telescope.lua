return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "smart" },
	vimgrep_arguments = {
	  "rg",
	  "--color=never",
	  "--no-heading",
	  "--with-filename",
	  "--line-number",
	  "--column",
	  "--smart-case",
	  "--fixed-strings",
	},
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
	  hidden = true,
	  no_ignore = true,
	  layout_config = { width = 0.5, height = 0.5 },
        },
        live_grep = {
          theme = "cursor",
	  hidden = true,
	  no_ignore = true,
	  layout_config = { width = 0.5, height = 0.5 },
        },
        buffers = {
          theme = "dropdown",
        },
        help_tags = {
          theme = "dropdown",
        },
      },
      extensions = {
        -- Add extensions here if needed
      },
    })
  end,
}
