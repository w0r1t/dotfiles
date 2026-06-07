-- 1. Сразу загружаем плагин в рантайм Neovim
vim.pack.add({ GH "christoomey/vim-tmux-navigator" })

-- 2. Аналог keys: настраиваем сочетания клавиш для навигации
vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
