return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Базовая настройка Neo-tree
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 30,
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
				},
			},
			source_selector = {
				winbar = true, -- Добавляет строку статуса наверх (winbar)
				statusline = false, -- Отключает нижнюю строку статуса плагина (если не нужна)
				show_scrolled_off_parent_node = true, -- Показывает родительский узел при прокрутке
				sources = { -- Настройка отображения источников
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
				},
				content_layout = "center", -- Центрирует текст (может быть "left", "right", "center")
				tabs_layout = "equal", -- Как распределяются вкладки ("equal" или "active")
			},
		})

		-- АВТООТКРЫТИЕ ПРИ СТАРТЕ
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Проверяем, что открыт пустой буфер или папка (например, `nvim .`)
				if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv(0)) ~= 0 then
					vim.cmd("Neotree focus")
				end
			end,
		})
	end,
}
