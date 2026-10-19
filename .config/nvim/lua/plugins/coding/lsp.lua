return {
	-- 1. Установка утилит через Mason
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = { ui = { border = "rounded" } },
	},

	-- 2. Автоматическое включение и привязка к новому API
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- Устанавливаем basedpyright вместо обычного pyright
			ensure_installed = { "lua_ls", "basedpyright", "ruff" },
			automatic_enable = true, -- Сама вызовет vim.lsp.enable()
		},
	},

	-- 3. Настройка логики работы серверов
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- === ГЛОБАЛЬНАЯ НАСТРОЙКА КЛАВИШ И ЛОГИКИ СЕРВЕРОВ ===
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					local opts = { buffer = bufnr, silent = true }
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						vim.tbl_extend("force", opts, { desc = "LSP Definition" })
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "Code Action" })
					)
					vim.keymap.set(
						"n",
						"<leader>cr",
						vim.lsp.buf.rename,
						vim.tbl_extend("force", opts, { desc = "Rename Symbol" })
					)

					-- РАЗДЕЛЕНИЕ ОБЯЗАННОСТЕЙ ДЛЯ PYTHON:
					-- Если прикрепился Basedpyright, отключаем у него встроенный линтинг/диагностику,
					-- так как этим будет заниматься Ruff. Basedpyright оставляем только для типов.
					if client.name == "basedpyright" then
						-- Отключаем встроенную диагностику синтаксиса
						client.server_capabilities.textDocument = client.server_capabilities.textDocument or {}
						if client.server_capabilities.textDocument.publishDiagnostics then
							client.server_capabilities.textDocument.publishDiagnostics = false
						end
					end

					-- Если прикрепился Ruff, отключаем его Hover (всплывающие подсказки),
					-- чтобы не перебивать более информативный Hover от Basedpyright.
					if client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end
				end,
			})

			-- === ТОНКАЯ НАСТРОЙКА ПАРАМЕТРОВ СЕРВЕРОВ (vim.lsp.config) ===

			-- Настройка Lua
			vim.lsp.config("lua_ls", {
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			})

			-- Настройка Basedpyright (Анализ типов)
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							-- Выключаем базовый линтинг (Ruff сделает это лучше)
							typeCheckingMode = "standard", -- Варианты: "off", "basic", "standard", "strict"
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})

			-- Настройка Ruff (Линтер и Форматтер)
			vim.lsp.config("ruff", {
				-- Вы можете передать пустую таблицу, основные правила Ruff
				-- считывает напрямую из вашего файла pyproject.toml или ruff.toml
				init_options = {
					settings = {
						-- Опции для ruff-сервера, если необходимы
						initOptions = {},
					},
				},
			})

			-- Автоматическое форматирование при сохранении с помощью Ruff
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.py",
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},
}
