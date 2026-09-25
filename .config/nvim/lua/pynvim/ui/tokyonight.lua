return {
  "folke/tokyonight.nvim",
  lazy = false, -- ensures the color scheme loads early
  priority = 1000, -- ensures the color scheme loads early
  config = function()
    require("tokyonight").setup({
      style = "storm", -- Choose from 'night', 'storm', 'moon', or 'day'
      -- other options
      transparent = false, -- set transparency
      terminal_colors = false, -- enables setting the terminal colors from the theme
    })
    vim.cmd [[colorscheme tokyonight]]
  end,
}

