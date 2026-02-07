return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { "markdown" },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    heading = {
    width = "block",
    left_pad = 0,
    right_pad = 4,
    icons = {},
    },
  },
}
