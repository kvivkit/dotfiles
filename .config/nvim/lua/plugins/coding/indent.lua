return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",

	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "│",
			smart_indent_cap = true, -- Убираем кап
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			include = {
				node_type = {
					["*"] = {
						"try_statement",
						"if_statement",
					},
				},
			},
		},
	},
}
