-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Execute Lua line/file
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the whole file" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Keybinds to control the size of splits (height/width)
vim.keymap.set("", "<M-,>", "<C-w>5<")
vim.keymap.set("", "<M-.>", "<C-w>5>")
vim.keymap.set("", "<M-t>", "<C-w>+")
vim.keymap.set("", "<M-s>", "<C-w>-")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function(args)
		-- Используем безопасные методы Neovim API для конкретного окна терминала,
		-- чтобы настройки интерфейса гарантированно не ломали другие буферы.
		local win = vim.fn.bufwinid(args.buf)
		if win > 0 then
			vim.wo[win].number = false
			vim.wo[win].relativenumber = false
			vim.wo[win].scrolloff = 0
		end
	end,
})
--   Easily hit escape in terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--   Open a terminal at the bottom of the screen with a fixed height
vim.keymap.set("n", ",st", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)
