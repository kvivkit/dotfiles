return {
	picker = {
		enabled = true,
		sources = {
			explorer = {
				hidden = true,
				ignored = true,
				exclude = {
					--".env",
					".git",
					".venv",
					".*cache",
				},
			},
		},
	},
}
