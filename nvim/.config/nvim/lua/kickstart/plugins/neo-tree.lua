-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local plugins = {
	{ src = GH("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("*") },
	GH("nvim-lua/plenary.nvim"),
	GH("MunifTanjim/nui.nvim"),
}

if vim.g.have_nerd_font then
	table.insert(plugins, GH("nvim-tree/nvim-web-devicons")) -- not strictly required, but recommended
end

vim.pack.add(plugins)

vim.keymap.set("n", "\\", "<Cmd>Neotree reveal<CR>", { desc = "NeoTree reveal", silent = true })

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		window = {
			mappings = {
				-- Навигация вверх-вниз по папкам
				["u"] = "navigate_up", -- u переносит корень на директорию выше
				["."] = "set_root", -- . делает выбранную папку новым корнем
				["\\"] = "close_window", -- Слэш закрывает окно, если фокус внутри дерева
			},
		},
	},
	popup_border_style = "rounded",
})
