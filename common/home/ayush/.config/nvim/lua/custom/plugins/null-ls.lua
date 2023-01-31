local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

  b.formatting.prettierd.with { filetypes = { "html", "markdown", "css" } },
  -- b.formatting.deno_fmt,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  --c,c++
  b.formatting.clang_format.with { filetypes = { "c", "cpp" } },
  -- python
  b.formatting.autopep8.with { filetypes = { "python" } },
}

local M = {}

M.setup = function()
  null_ls.setup {

    debug = true,
    sources = sources,
    offset_encoding = "utf-8",
    -- format on save
    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
    end,
  }
end

return M
