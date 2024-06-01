return {
  'vim-jp/vimdoc-ja',
  {
    'numToStr/Comment.nvim',
    lazy = false,
    init = function()
      require('Comment').setup()
    end,
  }
}
