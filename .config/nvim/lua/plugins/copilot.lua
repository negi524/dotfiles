return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = false, -- 手動でマッピングするため無効化
      },
    },
    panel = { enabled = false },
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    -- Copilotの提案がある場合のみTabで受け入れ、ない場合は通常のTabを実行
    vim.keymap.set("i", "<Tab>", function()
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        return vim.keycode("<Tab>")
      end
    end, { expr = true, silent = true })
  end,
}

