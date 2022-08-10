local telescope = require('telescope')
local map = vim.api.nvim_set_keymap

telescope.setup {
  pickers = {
    find_files = {
      -- theme = 'dropdown',
      -- previewer = false,
    }
  },
  extensions = {
    file_browser = {
      -- theme = 'dropdown',
      -- previewer = false,
    }
  }
}

require('telescope').load_extension "file_browser"

map('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
map('n', '<C-N>', ":Telescope file_browser<CR>", { noremap = true })
map('n', '<C-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
map('n', '<C-B>', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
