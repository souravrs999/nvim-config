local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

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
    'netrw',
    'netrwPlugin',
}

for i = 1, 10 do
    g['loaded_' .. disabled_built_ins[i]] = 1
end

-- Settings
opt.compatible = false
opt.list = true
opt.showcmd = false
opt.ruler = false
opt.listchars:append "eol:↴"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.textwidth = 100
opt.scrolloff = 7
opt.wrap = false
opt.wildignore = { '*.o', '*~', '*.pyc' }
opt.wildmode = 'longest,full'
opt.whichwrap:append '<,>,h,l'
opt.inccommand = 'nosplit'
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.smartcase = true
opt.tabstop = 4
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 4
opt.number = true
opt.smartindent = true
opt.laststatus = 3
opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append 'c'
opt.joinspaces = false
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.updatetime = 100
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.previewheight = 5
opt.undofile = true
opt.synmaxcol = 500
opt.display = 'msgsep'
opt.cursorline = true
opt.modeline = false
opt.mouse = 'nivh'
opt.signcolumn = 'yes:1'
opt.cmdheight = 0
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 200
opt.fillchars = [[vert:│,horiz:─,eob: ]]
opt.clipboard = "unnamedplus"
opt.swapfile = false

-- Colorscheme
opt.termguicolors = true

-- Lazy Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function()
            cmd [[colorscheme github_dark_default]]
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        config = function()
            require('indent_blankline').setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
                indent_blankline_use_treesitter = true,
                indent_blankline_indent_level = 4
            }
        end,
    },
    {
        'terrortylor/nvim-comment',
        event = "InsertEnter",
        config = function()
            require("nvim_comment").setup {
                hook = function()
                    require("ts_context_commentstring.internal").update_commentstring()
                end
            }
        end
    },
    {
        'nathom/filetype.nvim',
        init = function()
            require("filetype").setup {}
        end
    },
    {
        'lewis6991/impatient.nvim',
        init = function()
            require("impatient")
        end
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require "notify"
        end
    },
    {
        "windwp/nvim-autopairs",
        event = 'BufEnter',
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup {
                direction = "float",
                close_on_exit = true,
                persist_mode = true,
                auto_scroll = true,
                float_opts = {
                    border = "curved"
                }
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options =
                {
                    theme = 'github_dark_default',
                    icons_enabled = true,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                }
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = 'BufEnter',
        config = function()
            require("nvim-treesitter.configs").setup {
                context_commentstring = {
                    enable = true,
                    enable_autocmd = true,
                },
                ensure_installed = {
                    "lua", "vim", "css", "html", "javascript", "json", "lua", "python", "rust", "scss", "sql", "tsx",
                    "typescript", "go"
                },
                indent = {
                    enable = true
                },
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                }
            }
        end,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    float = {
                        enable = true,
                        open_win_config = {
                            relative = "editor",
                            border = "rounded",
                            width = 30,
                            height = 33,
                            row = 1,
                            col = 1,
                        },
                    },
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "BufEnter",
        config = function()
            require('gitsigns').setup {}
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
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
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "nvim-tree/nvim-web-devicons",              lazy = true },
    {
        'neovim/nvim-lspconfig',
        event = "BufEnter",
        dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
        config = function()
            local lspconfig = require('lspconfig')
            local null_ls = require('null-ls')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.prettierd
                }
            }

            -- TS server config
            lspconfig.tsserver.setup {
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                end }

            -- Python config
            lspconfig.pyright.setup {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true
                        }
                    }
                }
            }

            -- Lua config
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                }
            }
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'L3MON4D3/LuaSnip',         -- Snippets plugin
            'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local lspkind = require('lspkind')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            cmp.setup {
                perfomance = {
                    trigger_debounce_time = 500,
                    debounce = 300,
                    throttle = 60,
                    fetching_timeout = 200,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, { name = 'buffer' })
            }
        end,
    },
    { 'JoosepAlviste/nvim-ts-context-commentstring', event = "InsertEnter" },
    { 'preservim/tagbar' }
}

-- LazyGit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hiddent = true })

function _lazygit_toggle()
    lazygit:toggle()
end

-- Keybindings
local map = vim.api.nvim_set_keymap
local keymap = vim.keymap
local silent = { silent = true, noremap = true }

map('n', '<leader>T', '<cmd>ToggleTerm<CR>', silent)

keymap.set('n', '<space>e', vim.diagnostic.open_float)
keymap.set('n', '[d', vim.diagnostic.goto_prev)
keymap.set('n', ']d', vim.diagnostic.goto_next)
keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
map('n', 'tb', '<cmd>TagbarToggle<CR>', silent)

map('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', silent)
map('n', '<leader>gl', '<cmd>lua _lazygit_toggle()<CR>', silent)
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', silent)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', silent)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', silent)

-- Autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format { async = true }
    end
})
