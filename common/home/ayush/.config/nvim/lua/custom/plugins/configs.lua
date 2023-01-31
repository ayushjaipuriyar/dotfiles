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
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   autotag = {
      enable = true,
   },
}

M.nvimtree = {
   git = {
      enable = true,
   },
   view = {
      side = "right",
      width = 20,
   },
}

return M
