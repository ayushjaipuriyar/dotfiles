return {
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  ["sindrets/diffview.nvim"] = {
    -- requires = "plenary",
    config = function()
      require("diffview").setup {}
    end,
    cmd = { "DiffviewOpen" },
  },

  ["benfowler/telescope-luasnip.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension "luasnip"
    end,
    module = "telescope._extensions.luasnip", -- if you wish to lazy-load
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
}
