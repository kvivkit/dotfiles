local opt = vim.opt

-- Отступы и табуляция
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

--opt.list = true
--opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

-- Отображение
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.fillchars = { eob = " " }
opt.termguicolors = false
opt.mouse = "a"
opt.wrap = true
opt.cursorline = true
opt.signcolumn = "yes:1"
opt.scrolloff = 8

--opt.showcmd = true

-- Файлы и буферы
opt.undofile = true
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.clipboard = "unnamedplus"

--opt.backup = false

-- Поиск
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase =true

--opt.showmode = true

-- No automatic comment insertion
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]])
-- vim.cmd.colorscheme('tokyonight')

