return {
  -- 1. nvim-lspconfig теперь нужен ТОЛЬКО как база данных для серверов.
  -- Нам больше не нужно вручную вызывать require('lspconfig')[server].setup({})
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Инициализируем Mason для автоматической установки серверов
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright", "ruff" },
      })

      -- Использование нового нативного API Neovim 0.11+ вместо require('lspconfig')
      -- Настройки серверов теперь добавляются прямо в таблицу vim.lsp.config
      vim.lsp.config.basedpyright = {
        -- Здесь можно указать cmd или settings при необходимости
      }
      vim.lsp.config.ruff = {}

      -- Включаем (активируем) настроенные серверы
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ruff")

      -- Современный нативный способ привязки горячих клавиш (LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
