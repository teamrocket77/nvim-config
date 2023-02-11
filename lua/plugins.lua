local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

-- vim.cmd [[packadd packer.nvim]]
-- vim.cmd [[set background=light]]
vim.cmd [[ colorscheme gruvbox ]]
-- vim.cmd [[ autocmd VimEnter * hi Normal ctermbg=none ]]
vim.cmd [[ autocmd vimenter * ++nested colorscheme gruvbox ]]
vim.cmd [[set winheight=10]]
vim.cmd [[set winminheight=10]]

-- vim.cmd [[colorscheme tokyonight-night]]
-- vim.cmd [[colorscheme solarized]]
 -- "https://github.com/preservim/nerdtree"
packer.startup(function(use)
  -- path for confg ~/.cache/nvim/packer.nvim/
  -- for PackerSnapshot
  -- should create function that runs snapsot with date-time before running PackerSync
  use 'wbthomason/packer.nvim'

  use { 'L3MON4D3/LuaSnip' }

  use {
    'habamax/vim-rst',
    ft = {'rst'},
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use { 'nvim-tree/nvim-web-devicons'}
  -- use 'onsails/lspkind-nvim'

  use {'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
    {'neovim/nvim-lspconfig'},

    { "williamboman/mason.nvim"},
    { "williamboman/mason-lspconfig.nvim",},

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
  -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  use {'ellisonleao/gruvbox.nvim'}
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { "nvim-telescope/telescope.nvim", requires = {
    { "nvim-telescope/telescope-live-grep-args.nvim" }, }, config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
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
  use 'AndrewRadev/linediff.vim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})
end
)
