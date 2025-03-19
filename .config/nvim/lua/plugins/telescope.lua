return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
  }
