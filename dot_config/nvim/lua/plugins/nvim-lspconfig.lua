return {
  'neovim/nvim-lspconfig',
  -- Bufferが読み込まれるときをトリガーに遅延ロードする
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
      end,
    })
  end,
}
