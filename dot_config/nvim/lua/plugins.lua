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

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdtree'
  use 'ojroques/vim-oscyank'
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'neovim/nvim-lspconfig'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'rafcamlet/nvim-luapad'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'folke/tokyonight.nvim'
  use 'Rigellute/shades-of-purple.vim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons'}
  }
  use { 
    'fatih/vim-go', 
    run = ':GoUpdateBinaries' 
  }
  use 'NLKNguyen/papercolor-theme'
  use 'crusoexia/vim-monokai'
  -- diff 
  use { 
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'nvim-tree/nvim-web-devicons'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
    require("nvim-lsp-installer").setup({
      automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
      ui = {
          icons = {
              server_installed = "✓",
              server_pending = "➜",
              server_uninstalled = "✗"
          }
      }
  })
  end
end)
