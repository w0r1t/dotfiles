return {
	{ -- Статический анализ и проверка кода (Linting)
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			-- Настраиваем линтеры в зависимости от расширения (типа) файла
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				-- go = { "golangci-lint" },
			}

			-- Создаем автокоманду для автоматического запуска проверки кода
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
