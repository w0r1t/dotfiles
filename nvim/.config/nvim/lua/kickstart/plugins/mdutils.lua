return {
	{
		"w0r1t/mdutils.nvim",
		config = function()
			vim.api.nvim_create_user_command("UpdateProgress", function()
				require("mdutils").update_progress()
			end, {})
		end,
	},
}
