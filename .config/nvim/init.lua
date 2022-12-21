vim.opt.nu = true
vim.opt.rnu = true
vim.opt.wrap = false
vim.opt.spell = false
vim.opt.ruler = true
vim.opt.cindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.smartindent = false
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.laststatus = 0
vim.opt.shiftwidth = 2
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.cino = "p0"
vim.g.mapleader = " "
vim.opt.iskeyword:append("-")
vim.opt.clipboard = "unnamedplus"
vim.opt.formatoptions = vim.opt.formatoptions - "cro"

function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
	map("n", shortcut, command)
end

function imap(shortcut, command)
	map("i", shortcut, command)
end

function tmap(shortcut, command)
	map("t", shortcut, command)
end

-- better tabbing
nmap("<", "<gv")
nmap(">", ">gv")

-- easy escape
imap("jk", "<Esc>:w<CR>")
imap("kj", "<Esc>:w<CR>")

-- save & quit
nmap("<C-s>", ":w<CR>")
nmap("<C-S>", ":w!<CR>")
nmap("<C-q>", ":q!<CR>")
nmap("<Leader>s", ":w<CR>")

-- Better window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- switch buffer
nmap("<TAB>", ":BufferLineCycleNext<CR>")
nmap("<S-TAB>", ":bp<CR>")

-- capitalize word
imap("<c-u>", "<Esc>viwUi")
nmap("<c-u>", "viwUi<Esc>")

-- easy window resize
nmap("<M-j>", ":resize -2<CR>")
nmap("<M-k>", ":resize +2<CR>")
nmap("<M-h>", ":vertical resize -2<CR>")
nmap("<M-l>", ":vertical resize +2<CR>")

-- map ; to :
nmap(";", ":")
nmap(";", ":")

-- open terminal
nmap("TT", ":vs<CR>:set nornu<CR>:set nonu<CR>:te<CR>i")
nmap("bx", ":bd<CR>")

-- auto close parenthesis
--imap("{", "{}<Left>")
--imap("{<Space>", "<Esc>o{}<Left><CR><Up><Esc>o")
--
--imap("(", "()<Left>")
--imap("<", "<><Left>")
--imap("<<", "<<")
--imap("'", "''<Left>")
--imap('"', '""<Left>')
--imap("[", "[]<Left>")

-- New line in normal mode
nmap("<C-o>", "O<Esc>")
nmap("<Leader>j", "i<CR><ESC>")

-- pic active buffer
nmap("<Leader>p", ":BufferLinePick<CR>")

nmap("<Leader>e", ":NvimTreeToggle<CR>")
nmap("<F1>", ":lua require('FTerm').toggle()<CR>")
imap("<F1>", "<Esc>:lua require('FTerm').toggle()<CR>")
tmap("<F1>", "<C-\\><C-n>:lua require('FTerm').toggle()<CR>")

nmap("<F5>", ":CompetiTestRun<CR>")
imap("<F5>", "<Esc>:w<CR>:CompetiTestRun<CR>")

require("cfg/packer")
require("cfg/grvbox_bab")
require("cfg/bufferline")
require("cfg/nvimtree")
--require("cfg/lspconfig")
require("cfg/test")
require("cfg/cmp")
require("cfg/fterm")
require("cfg/treesitter")
require("cfg/colorizer")
require("cfg/vimwiki")
require("cfg/null_ls")
require("cfg/indentBlankLines")
