local opts = { noremap = true, silent = true }
local silent = { silent = true }

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')


-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)


-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers


-- vim.keymap.set('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<cr>', silent)
-- vim.keymap.set('n', '<space>1', ':lua NTGlobal["terminal"]:open(1)<cr>', silent)
-- vim.keymap.set('n', '<leader>+', ':lua NTGlobal["window"]:change_height(2)<cr>', silent)
-- vim.keymap.set('n', '<leader>-', ':lua NTGlobal["window"]:change_height(-2)<cr>', silent)

vim.api.nvim_set_keymap('n', '<space>t', ':lua terminal:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<space>1', ':lua terminal:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<space>2', ':lua terminal:open(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<space>3', ':lua terminal:open(3)<cr>', silent)

-- selected all
vim.keymap.set("n", '<C-a>', 'gg<S-v>G')


-- Split window
vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- New Tab
vim.keymap.set("n", "te", ":tabedit")

-- Move window
vim.keymap.set('n', '<Space>', '<C-w>w')
