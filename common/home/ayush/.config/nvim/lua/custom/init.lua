local new_cmd = vim.api.nvim_create_user_command

-- commands

-- I dont use shade.nvim/autosave.nvim all the time so made commands for them
-- So this makes easy to lazy load them at cmds

new_cmd("EnableShade", function()
   require("shade").setup()
end, {})

new_cmd("EnableAutosave", function()
   require("autosave").setup()
end, {})
