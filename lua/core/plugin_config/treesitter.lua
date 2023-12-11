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
    "vim",
    "astro",
    "cmake",
    "css",
    "fish",
    "gitignore",
    "go",
    "graphql",
    "java",
    "rust",
    "scss",
    "sql",
    "svelte",
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    disable = { "c", "rust" },
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
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" }
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    presist_queries = true,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    }
  }

})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.rust.filetype_to_parsername = { "rust" }

-- MDX
vim.filetype.add({
  extension = {
    mdx = "mdx"
  },
})
vim.treesitter.language.register("markdown", "mdx")
