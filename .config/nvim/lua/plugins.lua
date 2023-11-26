vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-jp/vimdoc-ja'
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signcolumn = number,
        numhl= true,
      }
    end
  }
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
end)
