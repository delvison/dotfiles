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
  },
  {
      "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
	  "LazyGit",
	  "LazyGitConfig",
	  "LazyGitCurrentFile",
	  "LazyGitFilter",
	  "LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
	  "nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
	  { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
  }
}
