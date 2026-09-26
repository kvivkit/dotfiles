-- Pull in the wezterm API
local wezterm = require('wezterm')

-- Функция определения текущей раскладки для macOS
local function get_keyboard_layout()
  -- Запуск утилиты issw (/opt/homebrew/bin/issw для Apple Silicon)
  local success, stdout, _ = wezterm.run_child_process { '/usr/local/bin/issw' }
  
  if success then
    -- Убираем лишние пробелы и переносы строк
    local layout = stdout:gsub('%s+', '')
    
    -- Проверяем наличие подстроки в ID раскладки
    if string.match(layout, 'Russian') then
      return ' RU '
    elseif string.match(layout, 'US') or string.match(layout, 'ABC') then
      return ' EN '
    end
  end
  return ' -- ' -- На случай ошибки или другой раскладки
end

local config = wezterm.config_builder()
-- Проверяем операционную систему
local is_mac = wezterm.target_triple:find("apple-darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- Plugins
local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')

-- This is where you actually apply your config choices.

-- The initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.color_scheme = 'Tokyo Night Storm'
-- or, changing the font size and color scheme.

if is_mac then
  config.font = wezterm.font("JetBrains Mono")
  config.font_size = 18.0
elseif is_linuxa then
  config.font = wezterm.font("JetBrains Mono")
  config.font_size = 14.0
else
  -- Резервный шрифт для других систем (например, Windows)
  config.font = wezterm.font("Fira Code")
  config.font_size = 13.0
end

  -- Настройка полей (в пикселях)
config.window_padding = {
	left = 5, -- отступ слева
	right = 5, -- отступ справа
	top = 5, -- отступ сверху
	bottom = 5, -- отступ снизу
}

config.key_map_preference = 'Physical'

-- Tabbar config
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true

tabline.setup({
  options = {
    theme = 'Tokyo Night Storm', -- Укажите название вашей темы
    icons_enabled = true,
  },
  sections = {
    -- Вставляем функцию как элемент таблицы в секцию Z (правый край)
    tabline_z = { 'domain', get_keyboard_layout },
  }
})

tabline.apply_to_config(config)

-- Finally, return the configuration to wezterm:
return config
