return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
      "pylsp",
      "ruby_lsp",
      "ts_ls",
      "vue_ls"
    },
  },
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}
