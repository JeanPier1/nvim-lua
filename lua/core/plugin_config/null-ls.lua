local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
  sources = {
    formatting.black,
    formatting.rustfmt,
    formatting.gofmt,
    formatting.goimports_reviser,
    formatting.golines,
    -- formatting.phpcsfixer,
    formatting.prettier,
    -- formatting.stylua,
    diagnostics.mypy,
    diagnostics.ruff,
    -- diagnostics.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" or client.name == "html" or client.name == "astro" then
      client.resolved_capabilities.document_formatting = false
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end,
})

---------------------------------
-- Auto commands
---------------------------------
-- vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])
