vim.pack.add({
	GH("neovim/nvim-lspconfig"),
	GH("mason-org/mason.nvim"),
	GH("mason-org/mason-lspconfig.nvim"),
	GH("WhoIsSethDaniel/mason-tool-installer.nvim"),
})

-- Automatically install LSPs and related tools to stdpath for Neovim
require("mason").setup({})

require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP серверы
		"lua-language-server", -- lua_ls
		"gopls",
		"json-lsp", -- jsonls
		"bash-language-server", -- bashls
		-- Форматтеры / линтеры
		"stylua",
		"goimports",
		"shfmt",
		"prettier",
		"markdownlint",
		"golangci-lint",
	},
})
