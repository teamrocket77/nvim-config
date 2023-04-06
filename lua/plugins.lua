local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[ colorscheme gruvbox ]]
vim.cmd [[ autocmd vimenter * ++nested colorscheme gruvbox ]]
vim.cmd [[set winheight=10]]
vim.cmd [[set winminheight=10]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'L3MON4D3/LuaSnip' }
  use { 'habamax/vim-rst',
    ft = {'rst'},
  }

  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  -- }

  -- very heavy not alwyas necessary
  -- not sure if this is needed, #TODO possibly remove
  -- for automatic linter setup
  -- use 'onsails/lspkind-nvim'
  use {'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- autolsp config might give error when initalizing
      {'neovim/nvim-lspconfig'},
      { "williamboman/mason.nvim"},
      { "williamboman/mason-lspconfig.nvim",},

      -- sm3xy suggestions
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'saadparwaiz1/cmp_luasnip'},
      {'rafamadriz/friendly-snippets'},

    }
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  -- colors
  use {'ellisonleao/gruvbox.nvim'}
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- enable ability for dir to be searched for files
  use { "nvim-telescope/telescope.nvim", requires = {
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "BurntSushi/ripgrep" },
    	}, config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  -- use { 'pixelneo/vim-python-docstring',
  -- 	opt = true,
  -- 	ft = 'py',
  -- }
  use { 'kkoomen/vim-doge',
    run = ':call doge#install()'
  }
  use 'AndrewRadev/linediff.vim'
  use({
    "iamcco/markdown-preview.nvim",
    ft = {'md'},
    run = function() vim.fn["mkdp#util#install"]() end,
})
  use {
	'untitled-ai/jupyter_ascending.vim',
  }
end
)
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])