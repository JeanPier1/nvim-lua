require('formatter').setup({
  logging = false,
  log_level = vim.log.levels.WARN,
  filetype = {
    json = { require("formatter.filetypes.json").fixjson },
    typescript = { require("formatter.filetypes.typescript").prettier },
    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettier,
    },
    html = {
      require("formatter.filetypes.html").prettier,
    },
    lua = { require("formatter.filetypes.lua").stylua },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
      function()
        -- Ignore already configured types.
        local defined_types = require("formatter.config").values.filetype
        if defined_types[vim.bo.filetype] ~= nil then
          return nil
        end
        vim.lsp.buf.format({ async = true })
      end,
    },
  }
})

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre * FormatWrite
augroup END
]]
-- vim.cmd [[
-- augroup Prettier
--   autocmd!
--   autocmd BufWritePre * Prettier
-- augroup END
-- ]]

vim.keymap.set("n", "<leader>f", function()
  if settings[vim.bo.filetype] ~= nil then
    vim.cmd([[Format]])
  else
    vim.lsp.buf.format()
  end
end)
