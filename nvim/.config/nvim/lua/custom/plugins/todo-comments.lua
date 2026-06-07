-- 1. Загружаем плагин и его зависимости в рантайм Neovim
vim.pack.add({GH"nvim-lua/plenary.nvim"})
vim.pack.add({GH"folke/todo-comments.nvim"})

-- 2. Вызываем базовую настройку плагина (аналог opts)
require("todo-comments").setup({
	signs = true,
})

-- 3. Настраиваем сочетания клавиш (аналог keys)
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]ODO comments" })

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
