local opt = vim.o
local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.expandtab = false
opt.incsearch = true
opt.tabstop = 4
opt.cursorline = true
opt.ignorecase = true
opt.hlsearch = true
opt.swapfile = false
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 7
opt.errorbells = false
opt.shiftwidth = 4
opt.numberwidth = 4
opt.termguicolors = true
opt.colorcolumn = '80'
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = 'yes'
opt.smartindent = true
opt.syntax = 'ON'
opt.mouse = "a"

map('n', 'vs', ':vs<CR>', opts)
map('n', 'sp', ':sp<CR>', opts)
map('n', '<C-L>', '<C-W><C-L>', opts)
map('n', '<C-H>', '<C-W><C-H>', opts)
map('n', '<C-K>', '<C-W><C-K>', opts)
map('n', '<C-J>', '<C-W><C-J>', opts)
map('n', 'tn', ':tabnew<CR>', opts)
map('n', 'tc', ':tabclose<CR>', opts)
map('n', 'tk', ':tabnext<CR>', opts)
map('n', 'tj', ':tabprev<CR>', opts)
map('n', 'to', ':tabo<CR>', opts)
map('n', '<C-S>', ':%s/', opts)
map('n', '<Esc>', '<C-\\><C-n>', opts)
map('n', '<Space>t', ":NvimTreeToggle<CR>", opts)
map('n', '<Space>T', ":FloatermNew --height=0.85 --width=0.8 --windtype=float --name=shell<CR>", opts)
