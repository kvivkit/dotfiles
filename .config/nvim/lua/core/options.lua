local opt = vim.opt

-- Отступы и табуляция
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- Текст
opt.textwidth = 120
opt.colorcolumn = "120"
opt.wrap = true -- Перенос длинных строк
-- Настройки невидимых символов
--opt.list = true
--opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

-- Отображение
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.fillchars = { eob = " " }
opt.termguicolors = true
opt.mouse = "a"
opt.cursorline = true
opt.signcolumn = "yes:1" -- Всегда показывать колонку знаков (для Git/ошибок) без скачков
opt.scrolloff = 8

-- Файлы и буферы
opt.undofile = true
opt.swapfile = false
opt.undodir = vim.fn.stdpath("cache") .. "/undo/"
opt.clipboard = "unnamedplus"

-- Поиск
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Отключение автоматического добавления комментариев на новой строке
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})
