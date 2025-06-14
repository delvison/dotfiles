return {
  {
    -- Ref: https://github.com/echasnovski/mini.files
    'echasnovski/mini.files',
    config = function()
      require("mini.files").setup()
      vim.keymap.set('n', '<leader>ee', '<cmd>lua Minifiles.open()<CR>', {})
    end
  }
}
