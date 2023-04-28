-- カラースキームに関する設定ファイル

-- 対応括弧の色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight MatchParen ctermfg=0 ctermbg=21 guifg=Black guibg=Blue1",
})

-- 行番号の色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight LineNr ctermfg=lightmagenta",
})

-- コメントの色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Comment ctermfg=243",
})

-- 通常の文字色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Normal ctermfg=248",
})

-- ポップアップメニュー(通常の項目)
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Pmenu ctermfg=232 ctermbg=255",
})

-- ポップアップメニュー(選択中の項目)
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight PmenuSel ctermfg=41 ctermbg=54",
})

-- ビジュアルモード選択
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Visual ctermbg=239",
})

vim.g.hybrid_custom_term_colors = 1               -- iTerm2用のhybrid設定
vim.cmd("colorscheme hybrid")
