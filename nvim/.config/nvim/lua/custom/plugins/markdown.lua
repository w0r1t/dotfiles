vim.pack.add({
	GH("nvim-treesitter/nvim-treesitter"),
	GH("nvim-mini/mini.nvim"), -- if you use the mini.nvim suite
	GH("nvim-tree/nvim-web-devicons"), -- if you prefer nvim-web-devicons
	GH("MeanderingProgrammer/render-markdown.nvim"),
})
require("render-markdown").setup({
	init = function()
		-- ХАК ДЛЯ CONCEALLEVEL: Включаем скрытие символов ТОЛЬКО для Markdown буферов.
		-- Это позволяет плагину прятать служебные маркеры (##, **) и рисовать вместо них
		-- красивые заголовки и списки, сохраняя глобальный conceallevel = 0 для кода.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			group = vim.api.nvim_create_augroup("markdown-conceal-settings", { clear = true }),
			callback = function()
				vim.opt_local.conceallevel = 2
			end,
		})
	end,
})
