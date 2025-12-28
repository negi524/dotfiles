return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      -- ヘルパー関数
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 基本操作
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'zo', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Preview'))
      vim.keymap.set('n', 'zO', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', 'zc', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
      vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "i", api.tree.toggle_gitignore_filter, opts("Toggle: ignore files"))
      vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))

      -- ファイル操作
      vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))

      -- その他
      vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end

    require('nvim-tree').setup({
      on_attach = on_attach,
      update_focused_file = {
        enable = true,
      },
    })

    -- グローバルキーマップ
    vim.keymap.set('n', '<leader><leader>', '<cmd>NvimTreeToggle<CR>', { desc = 'NvimTreeをトグルする' })
  end,
}

