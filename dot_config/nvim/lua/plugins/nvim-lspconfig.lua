return {
  'neovim/nvim-lspconfig',
  -- Bufferが読み込まれるときをトリガーに遅延ロードする
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Vueに関する設定
    -- https://github.com/vuejs/language-tools/wiki/Neovim
    local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
    vim.lsp.config('ts_ls', {
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
          },
        },
      },
    })

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
