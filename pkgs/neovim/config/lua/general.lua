vim.o.showcmd = true
vim.o.autoindent = true

vim.o.colorcolumn = '80'

-- Set shift width
vim.opt.shiftwidth = 2

-- Set soft tab stop
vim.opt.softtabstop = 2

-- Enable smart indent
vim.opt.smartindent = true

-- Enable wildmenu
vim.opt.wildmenu = true

-- Set wildmode
vim.opt.wildmode = { 'list', 'longest', 'full' }

-- Set backspace behavior
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- Enable line numbers
vim.opt.number = true

-- Ignore case in searches
vim.opt.ignorecase = true

-- Enable smart case-sensitive search
vim.opt.smartcase = true

-- Enable incremental search
vim.opt.incsearch = true

-- Highlight search matches
vim.opt.hlsearch = true

-- Disable hidden buffers
vim.opt.hidden = false

-- Highlight matching parentheses
vim.cmd('highlight MatchParen ctermbg=4')

-- Set status line to always show
vim.opt.laststatus = 2

-- Customize status line
vim.opt.statusline = '%F%m%r%h%w (%{&ff}){%Y} [%l,%v][%p%%]'

-- Set backup directory
vim.opt.backupdir = vim.fn.stdpath('config') .. '/backups'

-- Set swap file directory
vim.opt.directory = vim.fn.stdpath('config') .. '/backups'

-- Use system clipboard
vim.opt.clipboard:append('unnamedplus')

-- Enable relative line numbers
vim.opt.relativenumber = true
