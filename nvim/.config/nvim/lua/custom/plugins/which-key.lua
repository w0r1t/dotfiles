vim.pack.add({ GH"folke/which-key.nvim" })

require("which-key").setup({
	preset = "modern",

	-- Настройка задержки появления окна подсказок (в миллисекундах)
	delay = function(ctx)
		return ctx.plugin and 0 or 400
	end,

	icons = {
		-- Автоматически подтягивает красивые Nerd Font иконки для ваших клавиш и LSP
		mappings = vim.g.have_nerd_font,
		rules = {},
	},

	-- НОВЫЙ СИНТАКСИС V3: Декларативное описание групп хоткеев
	spec = {
		{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	},
})
