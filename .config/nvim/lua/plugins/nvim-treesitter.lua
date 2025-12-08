return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  config = function()
    -- mainブランチの新しいAPIを使用
    local ts = require("nvim-treesitter")

    -- パーサーを非同期でインストール
    ts.install({
      "lua",
      "typescript",
      "javascript",
      "vim",
      "markdown",
      "bash",
      "java",
      "ruby",
      "tsx",
      "vue",
      "json",
      "yaml",
      "python",
      "astro",
      "html",
      "css"
    })
  end,
}
