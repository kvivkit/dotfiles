return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate", -- Обновление парсеров при установке/апдейте плагина
		init = function()
			-- Автоматический запуск Treesitter-подсветки штатными средствами Neovim
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
		config = function()
			local ts = require("nvim-treesitter")

			-- Базовая инициализация плагина
			ts.setup()

			-- Список языков, которые вам необходимы
			local languages = { "lua", "python", "javascript", "typescript", "c", "rust", "go", "markdown" }

			-- Установка только отсутствующих парсеров
			ts.install(languages)
		end,
	},
}
