return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    -- 検索
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "^.git/",
        "^node_modules/",
        "^build/",
        "^dist/",
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
      mappings = {
        i = {
          ["<C-s>"] = function(prompt_bufnr)
            local actions = require('telescope.actions')
            actions.send_to_qflist(prompt_bufnr)
            actions.open_qflist(prompt_bufnr)
          end,
        },
        n = {
          ["<C-s>"] = function(prompt_bufnr)
            local actions = require('telescope.actions')
            actions.send_to_qflist(prompt_bufnr)
            actions.open_qflist(prompt_bufnr)
          end,
        },
      },
    }
  }
}
