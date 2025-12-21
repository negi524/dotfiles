return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  config = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldlevel = 99
    vim.opt.foldtext = ""

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
      "scss",
      "sql"
    }

    -- パーサーをインストール
    ts.install(languages):wait(300000)

    -- 指定したファイルタイプでTreesitterハイライトを有効化
    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function() vim.treesitter.start() end,
    })
  end,
}
