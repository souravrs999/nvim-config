local g = vim.g
local cmd = vim.cmd

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

require 'impatient'
require 'plugins'
require 'remaps'

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
    'gzip',
    'man',
    'matchit',
    'matchparen',
    'shada_plugin',
    'tarPlugin',
    'tar',
    'zipPlugin',
    'zip',
    'netrwPlugin',
}

for i = 1, 10 do
    g['loaded_' .. disabled_built_ins[i]] = 1
end

-- Settings
local o = vim.opt
o.textwidth = 100
o.scrolloff = 7
o.wildignore = { '*.o', '*~', '*.pyc' }
o.wildmode = 'longest,full'
o.whichwrap:append '<,>,h,l'
o.inccommand = 'nosplit'
o.lazyredraw = true
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.number = true
o.relativenumber = false
o.autoread = true
o.smartindent = true
o.laststatus = 3
o.showmode = false
o.shada = [['20,<50,s10,h,/100]]
o.hidden = true
o.wrap = false
o.shortmess:append 'c'
o.joinspaces = false
o.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
o.updatetime = 100
o.conceallevel = 2
o.concealcursor = 'nc'
o.previewheight = 5
o.undofile = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.clipboard = 'unnamedplus'
o.synmaxcol = 500
o.display = 'msgsep'
o.modeline = false
o.mouse = 'nivh'
o.signcolumn = 'yes:1'
o.cmdheight = 1
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.fillchars = [[vert:│,horiz:─,eob: ]]

-- Colorscheme
o.termguicolors = true
o.background = 'dark'
cmd [[colorscheme catppuccin]]

-- Plugins Initialization
-- catppuccin colorscheme
require("catppuccin").setup {
    flavour = "mocha",
    color_overrides = {
        mocha = {
            base = "#0d0d0d",
        },
    },
    integrations = {
        nvimtree = true,
    },
    highlight_overrides = {
        mocha = function(mocha)
            return {
                NvimTreeNormal = { bg = mocha.none },
            }
        end,
    },
}

-- Vim-Tree
require('nvim-tree').setup {
    auto_reload_on_write = true,
    view = {
        width = 20,
    }
}

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ["<C-c>"] = actions.close,
            }
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
        }
    }
}
require('telescope').load_extension('fzf')

-- Native LSP setup

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
     sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path'},
        { name = 'buffer'},
    }, {
            { name = 'buffer' },
        }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...'
        })
    }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- Typescript
require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'typescript-language-server', '--stdio'},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}

-- Lua
require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'lua-language-server '},
    filetypes = { 'lua' }
}

-- Rust Analyzer
require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' }
}

-- Pyright
require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' }
}

-- Treesitter
local ts = require('nvim-treesitter.configs')
ts.setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    ensure_installed = {
        "tsx",
        "css",
        "html",
        "json",
        "javascript",
        "typescript",
        "lua",
        "rust",
        "python"
    },
    autotag = {
        enable = true
    }
}
