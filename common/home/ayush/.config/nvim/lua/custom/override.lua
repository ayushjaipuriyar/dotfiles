-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "html",
    "css",
    "markdown",
    "jsonc",
    "c",
    "cpp",
    "typescript",
    "javascript",
    "rust",
    "kotlin",
    "java",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.blankline = {
  filetype_exclude = {
    "help",
    "terminal",
    "alpha",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvchad_cheatsheet",
    "lsp-installer",
    "norg",
    "",
  },
}

M.mason = {
  ensure_installed = {
    -- c/cpp stuff
    "clangd",
    "cpptools",
    "cpplint",
    -- lua stuff
    "lua-language-server",
    "stylua",
    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "emmet-ls",
    "json-lsp",
    -- Js
    "eslint-lsp",

    -- shell
    "shfmt",
    "shellcheck",
    "codespell",
    -- Bash
    "bash-language-server",

    -- python
    "flake8",
    "python-lsp-server",
    "autopep8",

    -- pretty
    "prettier",
    "prettierd",

    "sql-formatter",
    "sqlls",

    --java
    "jdtls",
  },
}
return M
