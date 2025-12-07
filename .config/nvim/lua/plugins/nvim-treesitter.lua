return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  opts = {
    ensure_installed = {
      "lua",
      "typescript",
      "javascript",
      "vim",
      "markdown",
      "bash",
      "java",
      "ruby",
      "tsx",
      "vue",
      "json",
      "yaml",
      "python",
      "astro",
      "html",
      "css"
    },
    sync_install = true,
    highlight = {
      enable = true,
    }
    },
}
