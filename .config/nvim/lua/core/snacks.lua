return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = function()
		local base_opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
      explorer = { enabled = true },
      image = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scroll = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = true },
		}

		local dashboard = require("plugins.ui.snacks-dashboard")
		local picker = require("plugins.ui.snacks-picker")

		-- Объединяем все настройки в один итоговый объект opts
		return vim.tbl_deep_extend("force", base_opts, {
			dashboard = dashboard,
			picker = picker,
		})
	end,

	keys = function()
		-- Горячие клавиши также можно вынести или оставить здесь
		return {
			{
				"<leader>e",
				function()
					Snacks.picker.explorer()
				end,
				desc = "Toggle File Explorer",
			},
		}
	end,
}
