return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = {
        char = "│",
        smart_indent_cap = false, -- Убираем кап
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        -- Убедитесь, что тут НЕТ параметра max_depth = 2
    },
  },
}

