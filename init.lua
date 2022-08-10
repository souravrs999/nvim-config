require('basics')
require('colors')
require('telescope-config')
require('coc-config')

require('nvim-treesitter.configs').setup {
	ensure_installed = { "javascript", "typescript", "rust", "python", "json", "html" },
	ignore_install = { "phpdoc" },
	context_commentstring = {
		enable = true
	},
	highlight = {
		enable = true,
		disable = { "lua" }
	},
	indent = {
		enable = true
	}
}

require('lualine').setup {
  options = {
    theme = 'onedark',
  }
}
require('nvim-tree').setup {}

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { 'neoclide/coc.nvim', branch = 'release' }
  	use 'casonadams/nord.vim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'tpope/vim-commentary'
	use 'JoosepAlviste/nvim-ts-context-commentstring'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'voldikss/vim-floaterm'
	use 'tpope/vim-fugitive'
	use 'navarasu/onedark.nvim'
	use 'ellisonleao/gruvbox.nvim'

  	use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  	use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use { 'nvim-telescope/telescope-file-browser.nvim' }
	use { 'ur4ltz/surround.nvim',
	config = function()
		require('surround').setup { mappings_style = "surround" }
	end
}

if packer_bootstrap then
	require('packer').sync()
end
end)
