-- A list of parser names, or "all"
-- Install parsers synchronously (only applied to `ensure_installed`)
require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "tsx", "typescript", "json", "css", "html", "markdown", "markdown_inline", "vim" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true
  },
  context_commetstring = {
    enable = true,
    enable_autocmd = false,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = 'tr'
      }
    }
  }
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
