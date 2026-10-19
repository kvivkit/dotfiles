return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Настройка Python LSP
			lspconfig.basedpyright.setup({
				settings = {
					basedpyright = {
						analysis = {
							-- Игнорируем базовые предупреждения, т.к. используем ruff
							ignore = { "*" },
							typeCheckingMode = "standard",
							diagnosticMode = "openFilesOnly",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
				-- Автоматический поиск .venv
				on_init = function(client)
					client.config.settings.basedpyright.venvPath = vim.fn.getcwd()
					client.config.settings.basedpyright.venv = ".venv"
					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					return true
				end,
			})

			-- Настройка Ruff для проверки кода
			lspconfig.ruff.setup({
				-- Оставляем только функции линтера, отключая hover-документацию,
				-- так как hover в Basedpyright информативнее (показывает типы данных)
				on_attach = function(client, bufnr)
					client.server_capabilities.hoverProvider = false

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.code_action({
								context = { only = { "source.organizeImports" } },
								apply = true,
							})
						end,
					})
				end,
			})

			-- Быстрые клавиши для LSP (переход к коду, подсказки)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Перейти к объявлению
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Показать документацию
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Исправить ошибку
				end,
			})
		end,
	},
}
