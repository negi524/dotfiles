return {
  "sindrets/diffview.nvim",
  lazy = true,
  config = function()
    local function open_pr_diff()
      -- 現在のブランチ名
      local current = vim.fn.systemlist("git branch --show-current")[1]

      -- GH CLI で base ブランチを取得
      local base = vim.fn.systemlist(
        "gh pr view --json baseRefName --jq .baseRefName 2>/dev/null"
      )[1]

      if base == nil or base == "" then
        print("GitHub PR が見つかりません。")
        return
      end

      -- Diffview で PR と同等の差分を表示
      vim.cmd("DiffviewOpen " .. base .. "..." .. current)
    end

    vim.keymap.set("n", "<leader>dfr", open_pr_diff, {
      desc = "Diffview: show diff of current PR",
    })
    vim.keymap.set("n", "<leader>dfw", "<cmd>DiffviewOpen<CR>", {
      desc = "Diffview: show diff of current file"
   })
  end,
}
