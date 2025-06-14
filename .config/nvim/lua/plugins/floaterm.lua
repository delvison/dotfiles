return {
  {
    -- Ref: https://github.com/voldikss/vim-floaterm
    'voldikss/vim-floaterm',
    config = function()
      vim.keymap.set('n', '<leader>;', ':FloatermToggle!<CR>', {})
    end
  }
}
