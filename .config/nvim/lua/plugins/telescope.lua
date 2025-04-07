return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true }),
  vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true }),
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
}
