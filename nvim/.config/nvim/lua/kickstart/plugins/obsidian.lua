return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Where to put new notes created from completion.
		new_notes_location = "current_dir",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required:
			"nvim-lua/plenary.nvim",
			-- Recommended:
			"epwalsh/pomo.nvim",
		},
		opts = {
			workspaces = require("kickstart/plugins/obsidian_workspaces"),
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
			templates = {
				folder = "_templates",
			},
			ui = {
				enable = false,
			},
		},
	},
}
