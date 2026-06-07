vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			telemetry = { enable = false },
		},
	},
})

local asdf_current = vim.fn.system("asdf current golang 2>/dev/null")
local go_version = asdf_current:match("golang%s+([%d%.]+)")
if go_version and go_version ~= "" then
	local asdf_go_root = vim.fn.system("asdf where golang 2>/dev/null"):gsub("%s+$", "")
	-- Структура asdf: <asdf_go_root>/go = GOROOT, <asdf_go_root>/packages = GOPATH
	vim.lsp.config("gopls", {
		cmd_env = {
			GOROOT = asdf_go_root .. "/go",
			GOPATH = asdf_go_root .. "/packages",
		},
		settings = {
			gopls = {
				staticcheck = true,
				gofumpt = true,
				usePlaceholders = true,
				analyses = {
					ST1000 = false, -- package comment
				}
			},
		},
	})
else
	vim.notify("LSP: версия Go через asdf не определена, gopls запустится без GOROOT/GOPATH", vim.log.levels.WARN)
	-- gopls всё равно включается ниже — mason его поставил, просто без кастомных путей
end

-- Вычисляем пути к бинарникам компилятора

vim.lsp.enable({ "lua_ls", "gopls", "jsonls", "bashls" })

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},

	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = false, -- Text shows up at the end of the line
	virtual_lines = true, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("K", vim.lsp.buf.hover, "LSP Hover")
		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gi", vim.lsp.buf.implementation, "Go to implementation")
		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local hl_group = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
