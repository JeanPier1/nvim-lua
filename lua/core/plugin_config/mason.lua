require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  opts = {
    ensure_installed = {
      "mypy",
      "ruff",
      "pyright",
      "stylua",
      "selene",
      "luacheck",
      "shellcheck",
      "shfmt",
      "tailwindcss-language-server",
      "typescript-language-server",
      "css-lsp",
    }
  },
  pip = {
    upgrade_pip = true,
    install_args = {},

  },
})
require("mason-lspconfig").setup({
  automtic_installation = true
})
