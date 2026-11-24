-- Treesitter для синтаксиса и отступов
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate", -- Обновление парсеров при установке/апдейте плагина
		init = function()
			-- Автоматический запуск Treesitter-подсветки штатными средствами Neovim
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "*" },
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
		config = function()
			local ts = require("nvim-treesitter")
			-- Базовая инициализация плагина. Нужна, если надо переопределить стандартные значения
			-- ts.setup()

			-- Список языков, которые вам необходимы
			local languages = {
				"python",
				"lua",
				"json",
				"html",
				"css",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"rust",
				"go",
				"markdown",
				"zsh",
			}
			ts.install(languages)
		end,
	},
}
