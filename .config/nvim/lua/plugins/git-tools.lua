return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
      vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', {})
    end
  },
  {
    -- https://github.com/sindrets/diffview.nvim
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', {})
      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', {})
    end
  }
}
