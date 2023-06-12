local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[ colorscheme gruvbox ]]
vim.cmd [[ autocmd vimenter * ++nested colorscheme gruvbox ]]
vim.cmd [[set winheight=10]]
vim.cmd [[set winminheight=10]]

-- 
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
--

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'L3MON4D3/LuaSnip' }
  use { 'habamax/vim-rst',
    ft = {'rst'},
  }
  -- undo tree -- very useful 
  use 'mbbill/undotree'


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
      -- require("telescope").load_extension("macros")
    end
  }
  use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  -- use { 'pixelneo/vim-python-docstring',
  -- 	opt = true,
  -- 	ft = 'py',
  -- }
  use { 'kkoomen/vim-doge',
    run = ':call doge#install()'
  }
  use 'AndrewRadev/linediff.vim'

  use {'mfussenegger/nvim-jdtls'}
  use({
    "iamcco/markdown-preview.nvim",
    ft = {'md'},
    run = function() vim.fn["mkdp#util#install"]() end,
})
  use {
	'untitled-ai/jupyter_ascending.vim',
  }
  -- use {
  --   -- https://github.com/ecthelionvi/NeoComposer.nvim
  -- "ecthelionvi/NeoComposer.nvim",
  -- requires = { "kkharji/sqlite.lua" }
  -- }
end
)
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
