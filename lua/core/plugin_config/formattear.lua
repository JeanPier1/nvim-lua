require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      -- prettierd
      function()
        return {
          exe = "prettierd",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    typescript = {
      function()
        return {
          exe = "prettierd",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    lua = {
      function()
        return {
          exe = "prettierd",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    -- other formatters ...
  }
})

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]]
