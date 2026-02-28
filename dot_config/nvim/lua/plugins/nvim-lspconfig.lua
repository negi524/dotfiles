return {
  'neovim/nvim-lspconfig',
  -- Bufferが読み込まれるときをトリガーに遅延ロードする
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    --- Launguage Serverに接続したときだけ設定される
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = "Attach key mappings for LSP functionalities",
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
      end,
    })
  end,
}
