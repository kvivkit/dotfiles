return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<c-\>]], -- Горячая клавиша для открытия/скрытия
      direction = 'horizontal', -- Варианты: 'horizontal', 'vertical', 'float'
      shade_terminals = true,
    })
  end
}
