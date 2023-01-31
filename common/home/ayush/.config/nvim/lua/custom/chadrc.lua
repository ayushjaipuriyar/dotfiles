local M = {}

local override = require "custom.override"

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },

    statusline = {
      separator_style = "round",
    },
  },
  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["williamboman/mason.nvim"] = override.mason,
    ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
    ["nvim-telescope/telescope.nvim"] = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
        },
      },
    },
  },
  user = require "custom.plugins",

  remove = {
    "folke/which-key.nvim",
  },
}
M.ui = {
  theme = "rxyhn",
}

M.mappings = require "custom.mappings"

M.options = {
  user = function()
    vim.opt.swapfile = false
  end,
}

return M
