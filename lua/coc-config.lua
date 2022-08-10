local map = vim.api.nvim_set_keymap
local opt = vim.o

map("n", "<leader>.", "<plug>(coc-codeaction)", {})
map("n", "<leader>l", ":coccommand eslint.executeautofix<cr>", {})
map("n", "gd", "<plug>(coc-definition)", {silent = true})
map("n", "<leader>rn", "<plug>(coc-rename)", {})
map("n", "<leader>f", ":CocCommand prettier.formatFile<cr>", {noremap = true})
map("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
map('n', ']d', "<plug>(coc-diagnostic-prev)", { silent = true })
map('n', '[d', "<plug>(coc-diagnostic-next)", { silent = true })
map('i', '<C-j>', [[coc#pum#visible() ? coc#pum#next(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext', [])<CR>" : "\<C-j>"]], { silent = true, noremap = true, expr = true})
map('i', '<C-k>', [[coc#pum#visible() ? coc#pum#prev(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev', [])<CR>" : "\<C-k>"]], { silent = true, noremap = true, expr = true})

opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
