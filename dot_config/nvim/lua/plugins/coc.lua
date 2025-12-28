return {
  'neoclide/coc.nvim',
  branch = 'release',
  lazy = false,
  config = function()
    -- キーマッピング設定
    local keyset = vim.keymap.set

    -- オプション設定
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

    -- Enterで選択した補完アイテムを確定、またはcoc.nvimにフォーマットを通知
    -- <C-g>uは現在のundoを中断します
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    -- GoTo コードナビゲーション
    keyset("n", "<leader>gd", "<Plug>(coc-definition)", {silent = true})
    keyset("n", "<leader>gy", "<Plug>(coc-type-definition)", {silent = true})
    keyset("n", "<leader>gi", "<Plug>(coc-implementation)", {silent = true})
    keyset("n", "<leader>gr", "<Plug>(coc-references)", {silent = true})
  end
}
