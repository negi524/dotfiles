return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  config = function()
    -- mainブランチの新しいAPIを使用
    local ts = require("nvim-treesitter")

    -- インストール・ハイライト対象の言語リスト
    local languages = {
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
      "css",
      "scss"
    }

    -- パーサーを非同期でインストール
    ts.install(languages)

    -- 指定したファイルタイプでTreesitterハイライトを有効化
    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
