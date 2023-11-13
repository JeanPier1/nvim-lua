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
      "pyright"
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
