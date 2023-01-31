local ft_cmds = {
  python = "python3 " .. vim.fn.expand "%",
  cpp = "g++ " .. vim.fn.expand "%" .. " -o " .. vim.fn.expand "%:r" .. " && ./" .. vim.fn.expand "%:r",
  -- java = "javac " .. vim.fn.expand "%" .. " && java -cp " .. vim.fn.expand "%:p:h" .. "/" .. vim.fn.expand "%:t:r",
  java = "javac " .. vim.fn.expand "%" .. " && java " .. vim.fn.expand "%:r",
  -- bash = "bash " .. vim.fn.expand "%",
}
local M = {}
M.shade = {
  n = {
    ["<leader>s"] = {
      function()
        require("shade").toggle()
      end,

      "   toggle shade.nvim",
    },
  },
}

M.nvterm = {
  n = {
    ["<C-l>"] = {
      function()
        require("nvterm.terminal").send(ft_cmds[vim.bo.filetype])
      end,
    },
  },
}

M.lsp = {
  n = {

    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      " telescope lsp diagnostics",
    },
  },
  v = {
    ["<leader>ca"] = { "<cmd> '<,'> lua vim.lsp.buf.range_code_action()<CR>", "range code actions" },
  },
}

vim.keymap.set("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { expr = true })

vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true })

return M
