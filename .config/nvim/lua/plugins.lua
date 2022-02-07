return require('packer').startup({function()

  use 'wbthomason/packer.nvim'

  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons',}
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use 'lukas-reineke/indent-blankline.nvim'
  use "numToStr/FTerm.nvim"
  use "norcalli/nvim-colorizer.lua"
  use({'catppuccin/nvim', as = 'catppuccin'})

  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind-nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'rafamadriz/friendly-snippets'
  use 'L3MON4D3/LuaSnip'

  use 'vimwiki/vimwiki'

end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'single' }
      end,
      prompt_border = 'single',
    },
    git = {
      clone_timeout = 600, -- Timeout, in seconds, for git clones
    },
    auto_clean = true,
    compile_on_sync = true,
  }
})


