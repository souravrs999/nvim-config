local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local conf = {
    profile = {
        enable = true,
        threshold = 0
    },
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    }
}

local packer_bootstrap = ensure_packer()
local packer = require 'packer'
packer.init(conf)
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'catppuccin/nvim'
    use 'lewis6991/impatient.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'onsails/lspkind.nvim'
    use {
        's1n7ax/nvim-terminal',
        config = function()
            event = 'VimEnter'
            vim.o.hidden = true
            require('nvim-terminal').setup({
                disable_default_keymaps = false,
                toggle_keymap = '<leader>T',
            })
        end,
    }
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPre",
        config = function()
            require('gitsigns').setup()
        end,
    }
    use {
        'dinhhuy258/git.nvim',
        event = "BufReadPre",
        config = function()
            require('git').setup({
                default_mappings = true, 
                keymaps = {
                    blame = "<Leader>gb",
                    quit_blame = "q",
                    blame_commit = "<CR>",
                    browse = "<Leader>go",
                    open_pull_request = "<Leader>gp",
                    create_pull_request = "<Leader>gn",
                    diff = "<Leader>gd",
                    diff_close = "<Leader>gD",
                    revert = "<Leader>gr",
                    revert_file = "<Leader>gR",
                }
    })
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        event = 'VimEnter',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin'
                }
            })
        end,
    }
    use {
        'numToStr/Comment.nvim',
        event = "BufReadPre",
        config = function()
            require('Comment').setup()
        end,
    }
    use {
        'windwp/nvim-autopairs',
        event = "BufReadPre",
        config = function()
            require('nvim-autopairs').setup()
        end,
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = "BufReadPre",
        config = function()
            require('indent_blankline').setup()
        end,
    }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
