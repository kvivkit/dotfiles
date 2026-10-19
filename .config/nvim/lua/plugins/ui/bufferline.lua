return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- или "tabs" для вкладок редактора
				numbers = "none", -- можно изменить на "ordinal" или "buffer_id"
				diagnostics = "nvim_lsp", -- показ ошибок/предупреждений от LSP
				separator_style = "slant", -- стили рамок: "slant", "padded_slant", "block", "thin"
				show_buffer_close_icons = true,
				show_close_icon = true,
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "File explorer", -- Текст, который будет виден сверху
						text_align = "center", -- Выравнивание текста ("left", "center", "right")
						highlight = "Directory",
						separator = true, -- Вертикальный разделитель между смещением и вкладками
					},
				},
				close_command = function(n)
					Snacks.bufdelete(n)
				end,
				right_mouse_command = function(n)
					Snacks.bufdelete(n)
				end,
			},
		})
	end,
}
