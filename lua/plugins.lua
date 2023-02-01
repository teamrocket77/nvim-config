local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[set background=light]]
vim.cmd [[set winheight=10]]
vim.cmd [[set winminheight=10]]

-- vim.cmd [[colorscheme tokyonight-night]]
-- vim.cmd [[colorscheme solarized]]
 -- "https://github.com/preservim/nerdtree"
packer.startup(function(use)
  -- path for confg ~/.cache/nvim/packer.nvim/
  -- for PackerSnapshot
  -- should create function that runs snapsot with date-time before running PackerSync
  use {
    'LnL7/vim-nix',
    ft = {'nix'}
  }
  use {'regen100/cmake-language-server',
    run = 'pip install cmake-language-server'
    }
  use {'MaskRay/ccls', 
    run = 'cmake --build . --config Release --target install'}
  use 'wbthomason/packer.nvim'
  use 'shaunsingh/solarized.nvim'
  use {
    'folke/tokyonight.nvim',
  }
  use { 'L3MON4D3/LuaSnip' }
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' --snippets source

  use {
    'euclidianAce/BetterLua.vim',
    ft = {'lua'},
  }
  use {
    'habamax/vim-rst',
    ft = {'rst'},
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }


  use 'williamboman/nvim-lsp-installer'
  use 'mfussenegger/nvim-jdtls'
  use 'onsails/lspkind-nvim'
  use 'neovim/nvim-lspconfig'
  use 'preservim/nerdtree'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  use {'ellisonleao/gruvbox.nvim'}
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'PhilRunninger/nerdtree-buffer-ops'
  use 'PhilRunninger/nerdtree-visual-selection'
  use 'jiangmiao/auto-pairs'
  use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",}
  use 'yuezk/vim-js'
  use 'HerringtonDarkholme/yats.vim'
  use 'maxmellon/vim-jsx-pretty'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { "nvim-telescope/telescope.nvim", requires = { { "nvim-telescope/telescope-live-grep-args.nvim" }, }, config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup { }
    end
  }
  use { 'pixelneo/vim-python-docstring' }
  use {
    'heavenshell/vim-jsdoc',
    ft = {'js', 'jsx', 'ts', 'txs'},
    run = 'make install'
  }

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})
end
)
