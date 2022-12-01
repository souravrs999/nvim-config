local silent = { silent = true, noremap = true }
local map = vim.keymap.set

-- Nvim Tree Toggle
map('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', silent)

-- Window navigation
map('n', 'vs', '<cmd>vs<CR>', silent)
map('n', 'sp', '<cmd>sp<CR>', silent)
map('n', '<C-h>', '<cmd>wincmd h<CR>', silent)
map('n', '<C-j>', '<cmd>wincmd j<CR>', silent)
map('n', '<C-k>', '<cmd>wincmd k<CR>', silent)
map('n', '<C-l>', '<cmd>wincmd l<CR>', silent)
map('n', 'tn', '<cmd>tabnew<CR>', silent)
map('n', 'tc', '<cmd>tabclose<CR>', silent)
map('n', 'tk', '<cmd>tabnext<CR>', silent)
map('n', 'tj', '<cmd>tabprevious<CR>', silent)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', silent)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', silent)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', silent)

-- Diagnostics
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)
