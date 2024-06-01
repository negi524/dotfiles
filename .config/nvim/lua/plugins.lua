return {
  'vim-jp/vimdoc-ja',
  {
    'numToStr/Comment.nvim',
    lazy = false,
    init = function()
      require('Comment').setup()
    end,
  },
  {
    'navarasu/onedark.nvim',
    init = function()
      require('onedark').load()
    end,
  },
}
