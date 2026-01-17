-- カラースキーム設定
local colorscheme = 'nightfox'

return {
  -- onedark
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    cond = colorscheme == 'onedark',
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = true,
      }
      require('onedark').load()
    end
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    cond = colorscheme == 'nightfox',
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true,
        }
      })
      vim.cmd.colorscheme('nightfox')
    end
  }
}
