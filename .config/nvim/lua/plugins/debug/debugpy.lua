return {
	{
		"mfussenegger/nvim-dap",
		ft = { "python" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			-- Горячие клавиши для отладки тестов (Pytest)
			{
				"<leader>dt",
				function()
					require("dap-python").test_method()
				end,
				desc = "Debug: Test Method",
			},
			{
				"<leader>dc",
				function()
					require("dap-python").test_class()
				end,
				desc = "Debug: Test Class",
			},
			{
				"<leader>ui",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Путь к изолированному debugpy
			local python_path = vim.fn.expand("~/.local/share/nvim/dap-python/bin/python")
			require("dap-python").setup(python_path)

			-- 1. НАСТРОЙКА PYTEST
			-- Указываем dap-python использовать pytest вместо стандартного unittest
			require("dap-python").test_runner = "pytest"

			-- 2. НАСТРОЙКА FASTAPI
			-- Добавляем конфигурацию запуска uvicorn прямо в список питоновских конфигураций
			table.insert(dap.configurations.python, {
				type = "python",
				request = "launch",
				name = "FastAPI: Run Server",
				module = "uvicorn",
				args = {
					"main:app", -- Путь к вашему приложению (замените, если главный файл называется иначе, например app.main:app)
					"--reload", -- Автоперезагрузка при изменении кода
					"--port",
					"8000", -- Порт
				},
				jinja = true, -- Поддержка брейкпоинтов в шаблонах, если используются
				console = "integratedTerminal",
			})

			-- Иконки
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "Visual", numhl = "" })
		end,
	},
}
