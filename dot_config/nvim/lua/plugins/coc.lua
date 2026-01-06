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

    -- Kキーでドキュメント・型情報を表示
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end
    keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
  end
}
