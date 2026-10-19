return {
	"willothy/wezterm.nvim",
	config = function()
		require("wezterm").setup({
			-- Автоматически обновлять CWD в WezTerm при смене папки в Neovim
			create_commands = true,
			-- Включает бесшовную интеграцию путей
			register_user_commands = true,
		})
	end,
}
