local function map(mode, lhs, rhs, desc_or_opts)
  local opts = {}
  if type(desc_or_opts) == "string" then
    opts = { desc = desc_or_opts }
  elseif type(desc_or_opts) == "table" then
    opts = desc_or_opts
  end
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<Esc>", ":noh<CR>", "Clear Highlight")

map("n", "]b", ":bnext<CR>", "Next Buffer")
map("n", "[b", ":bprevious<CR>", "Previous Buffer")

map("n", "<C-h>", "<C-w>h", "Move left")
map("n", "<C-j>", "<C-w>j", "Move down")
map("n", "<C-k>", "<C-w>k", "Move up")
map("n", "<C-l>", "<C-w>l", "Move right")


map('n', '<leader>e', ':Neotree toggle left<CR>', 'Toggle Neo-tree')
map('n', '<leader>f', ':Neotree focus<CR>', 'Focus Neo-tree')

