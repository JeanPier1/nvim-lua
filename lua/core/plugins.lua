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

  -- java
  "mfussenegger/nvim-jdtls",

  -- python debugger
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function(_, opts)
      local path = "~/AppData/Local/nvim-data/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end
  },
  {
    "microsoft/vscode-node-debug2"
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end
  }
}


local opts = {}

require("lazy").setup(plugins, opts)
