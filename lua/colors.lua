require('onedark').setup {
  style = "darker",
  term_colors = true,
  code_style = {
    comments = "italic",
  },
  diagnostics = {
    darker = true,
    undercurl = true,
    background = true,
  }
}
require('onedark').load()

-- require('gruvbox').setup({
-- 	undercurl = true,
-- 	underline = true,
-- 	bold = true,
-- 	italic = true,
-- 	strikethrough = true,
-- 	invert_selection = false,
-- 	invert_signs = false,
-- 	invert_tabline = false,
-- 	invert_intend_guides = false,
-- 	inverse = true,
-- 	contrast = "hard"
-- })
vim.o.background = 'dark'
-- vim.cmd([[colorscheme gruvbox]])
