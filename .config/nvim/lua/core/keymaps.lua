vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { noremap = true, silent = false })

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize pane with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Pane navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", opts)
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", opts)
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", opts)
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", opts)

-- Split shortcuts
-- vim.keymap.set("n", "<C-w>v", opts)
-- vim.keymap.set("n", "<C-w>s", opts)

-- Select last edited/pasted text
vim.keymap.set("n", "gV", "[v", opts)

-- Select pasted text
vim.keymap.set("n", "gp", "[v", opts)

-- Tab navigation
vim.keymap.set("n", "tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "tk", ":tabnext<CR>", opts)
vim.keymap.set("n", "tj", ":tabprev<CR>", opts)
vim.keymap.set("n", "tl", ":tablast<CR>", opts)
vim.keymap.set("n", "tx", ":tabclose<CR>", opts)

-- Buffer navigation
vim.keymap.set("n", "<C-N>", ":bnext<CR>", opts)
vim.keymap.set("n", "<C-P>", ":bprev<CR>", opts)
vim.keymap.set("n", "<C-W>", ":bdelete<CR>", opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- copy paste x11
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', opts)
vim.api.nvim_set_keymap('n', '<C-b>', '"+p', opts)

-- grep
vim.keymap.set("n", "<leader>gg", ":copen | :grep ", { noremap = true, silent = false })

-- insert date
vim.keymap.set("n", "<leader>d", ":put =strftime('%Y-%m-%d')<CR>", opts)

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Map Ctrl+L to insert - [ ]
vim.keymap.set('i', '<C-l>', '- [ ] ', { noremap = true })

-- Map Ctrl+K to insert []()
vim.keymap.set('i', '<C-k>', '[]()', { noremap = true })

-- Function to replace content inside <think> tags with empty tags
function toggle_checkbox()
    vim.cmd('normal! 0')
    local cur_pos = vim.fn.getcurpos()
    local current_line = vim.fn.getline(cur_pos.line)
    local found = string.find(current_line, '- \\[ \\]')
    if found == 0 then
        vim.notify("No list item found", vim.log.levels.INFO)
        return
    end

    vim.cmd('normal! 0')
    -- Enter visual mode, search for closing tag and select content
    vim.cmd('normal! v')
    vim.cmd('normal! f]')

    -- Replace with empty tags
    vim.cmd('normal! c- [x]')

    -- Move down one line and to the beginning
    vim.cmd('normal! j0')
end

vim.keymap.set('n', '<leader>l', '<cmd>lua toggle_checkbox()<CR>', { noremap = true, silent = true })
