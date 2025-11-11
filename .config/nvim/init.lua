require 'core.options'
require 'core.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- 'airblade/vim-gitgutter',
  'ap/vim-buftabline',
  'ap/vim-css-color',
  'artempyanykh/marksman',
  'bullets-vim/bullets.vim',
  'fatih/vim-go',
  'jiangmiao/auto-pairs',
  'jvirtanen/vim-hcl',
  'mhinz/vim-startify',
  -- 'neoclide/coc.nvim',
  'neovim/nvim-lspconfig',
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  require 'plugins.neotree',
  require 'plugins.git-tools',
  require 'plugins.colortheme',
  require 'plugins.lualine',
  require 'plugins.blink',
  require 'plugins.live-preview',
  require 'plugins.markdown_nvim',
  require 'plugins.oil',
  require 'plugins.treesitter',
  require 'plugins.mason',
  require 'plugins.floaterm',
  require 'plugins.minifiles',
  require 'plugins.telescope'
})

-- Custom highlight color
vim.api.nvim_set_hl(0, 'Visual', { bg = '#a7c080', fg = '#000000' })
vim.api.nvim_set_hl(0, 'Search', { bg = '#33cc33', fg = '#000000' })

-- Autocmd to apply highlights when colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
 pattern = '*',
 callback = function()
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#a7c080', fg = '#000000' })
    vim.api.nvim_set_hl(0, 'Search', { bg = '#33cc33', fg = '#000000' })
 end,
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- -- Syntax hilighting in notes
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--  pattern = { "*.lua" },
--  callback = function()
--     -- Remove existing autocommands in the group
--     vim.api.nvim_del_autocmd("vimrc_todo")
--     -- Add new autocommands
--     vim.api.nvim_create_autocmd("Syntax", {
--       group = "vimrc_todo",
--       pattern = "*",
--       callback = function()
--         vim.api.nvim_set_hl(0, "MyTodo", { bg = "#DCDCAA", fg = "#000000" })
--         vim.api.nvim_set_hl(0, "MyTodo", {})
--       end
--     })
--  end
-- })
-- vim.api.nvim_set_hl(0, "MyTodo", { bg = "#DCDCAA", fg = "#000000" })
