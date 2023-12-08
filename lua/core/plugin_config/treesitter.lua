-- A list of parser names, or "all"
-- Install parsers synchronously (only applied to `ensure_installed`)
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "lua",
    "rust",
    "tsx",
    "typescript",
    "json",
    "css",
    "html",
    "markdown",
    "markdown_inline",
    "vim" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
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
  -- refactor = {
  --   highlight_definitions = {
  --     enable = true,
  --     clear_on_cursor_move = true,
  --   },
  --   highlight_current_scope = { enable = true },
  --   smart_rename = {
  --     enable = true,
  --     keymaps = {
  --       smart_rename = 'tr'
  --     }
  --   }
  -- }
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.rust.filetype_to_parsername = { "rust" }
