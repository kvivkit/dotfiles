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

