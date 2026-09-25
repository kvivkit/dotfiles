return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Настройка Python LSP
      lspconfig.basedpyright.setup({})
      
      -- Настройка Ruff для мгновенной проверки кода
      lspconfig.ruff.setup({})

      -- Быстрые клавиши для LSP (переход к коду, подсказки)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Перейти к объявлению
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)       -- Показать документацию
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Исправить ошибку
        end,
      })
    end,
  },
}

