return{
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = { "basedpyright", "ruff", "lua_ls", "stylua" }
  },
  config = function(_, opts)
    -- basedpyright: проверка типов без лишнего дублирования
    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    -- ruff: линтинг и форматирование Python
    vim.lsp.config("ruff", {
      on_attach = function(client, _)
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    -- Lua: отключаем встроенное форматирование, так как используем stylua
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          format = { enable = false },
        },
      },
    })
    require("mason-lspconfig").setup(opts)
  end,
}
