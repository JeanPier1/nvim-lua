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

local plugins = {
  'wbthomason/packer.nvim',
  'ellisonleao/gruvbox.nvim',
  'rebelot/kanagawa.nvim',
  {
    'dracula/vim',
    lazy = false,
  },
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
  },
  'nvim-treesitter/nvim-treesitter-refactor',
  'bluz71/vim-nightfly-colors',
  'vim-test/vim-test',
  'lewis6991/gitsigns.nvim',
  -- 'preservim/vimux',
  -- 'christoomey/vim-tmux-navigator',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',

  -- rust babyyyyyyy
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'simrat39/rust-tools.nvim',

  -- completion
  'hrsh7th/nvim-cmp',
  'uga-rosa/cmp-dictionary',
  'hrsh7th/cmp-nvim-lsp',
  --'hrsh7th/nvim-buffer',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  "rafamadriz/friendly-snippets",
  "github/copilot.vim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "glepnir/lspsaga.nvim",

  -- startify
  "mhinz/vim-startify",

  --terminal
  "s1n7ax/nvim-terminal",

  --format
  "MunifTanjim/prettier.nvim",
  "mhartington/formatter.nvim",

  -- use neovim as a language server to enject LSP diagnostics, code actions, and more via L
  "jose-elias-alvarez/null-ls.nvim",


  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  "folke/zen-mode.nvim",
  "onsails/lspkind-nvim",

  -- dictionary
  "kkharji/sqlite.lua",
}


local opts = {}

require("lazy").setup(plugins, opts)