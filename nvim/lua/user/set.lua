
-- Make relative line numbers default.
vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

-- Do not wrap lines, but if enabled, wrapped lines continue
-- visually indented.
vim.o.wrap = false
vim.o.breakindent = true

-- Replace built-in swap and backup by undo.
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = true
vim.o.incsearch = true

-- Ignore case in search pattern unless there's an upper case letter.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable 24-bit RGB color in the TUI.
vim.o.termguicolors = true
vim.g.have_nerd_font = true
vim.g.airline_powerline_fonts = 1

-- Always draw the sign column.
vim.o.signcolumn = "yes"

-- Enable mouse mode.
vim.o.mouse = "a"

-- Split new windows below the current one and to the right.
vim.o.splitbelow = true
vim.o.splitright = true

-- Do not have `o` add a comment prefix.
vim.opt.formatoptions:remove "o"

-- Show the effects of a command incrementally in a preview window.
vim.inccommand = "split"

-- Keep all folds open by default.
vim.o.foldenable = false

