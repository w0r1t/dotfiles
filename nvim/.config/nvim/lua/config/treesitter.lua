-- [[ Настройка нативной подсветки Treesitter (v0.12+) ]]
-- Обернуто в augroup для предотвращения дублирования в памяти при перезагрузке конфига.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Нативное включение подсветки Treesitter для поддерживаемых языков",
	group = vim.api.nvim_create_augroup("custom-treesitter-highlight", { clear = true }),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype

		if ft == "" or ft:match("^Telescope") or ft == "NvimTree" or ft == "lazy" then
			return
		end

		local lang = vim.treesitter.language.get_lang(ft) or ft

		local has_parser = pcall(vim.treesitter.language.add, lang)

		if has_parser then
			pcall(vim.treesitter.start, args.buf, lang)
		end
	end,
})
