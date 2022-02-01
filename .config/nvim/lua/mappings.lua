function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- better tabbing
nmap('<', '<gv') 
nmap('>', '>gv')

-- easy escape
imap('jk', '<Esc>') 
imap('kj', '<Esc>')

-- save & quit
nmap('<C-s>', ':w<CR>') 
nmap('<C-S>', ':w!<CR>') 
nmap('<C-q>', ':q!<CR>') 

-- Better window navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- switch buffer 
nmap('<TAB>', ':bn<CR>') 
nmap('<S-TAB>', ':bp<CR>') 

-- capitalize word
imap('<c-u>', '<Esc>viwUi') 
nmap('<c-u>', 'viwUi<Esc>')

-- easy window resize
nmap('<M-j>', ':resize -2<CR>') 
nmap('<M-k>', ':resize +2<CR>')
nmap('<M-h>', ':vertical resize -2<CR>')
nmap('<M-l>', ':vertical resize +2<CR>')

-- map ; to :
nmap(';', ':')
nmap(';', ':')    

-- open terminal
nmap('TT',':vs<CR>:set nornu<CR>:set nonu<CR>:te<CR>i')
nmap('bx',':bd<CR>')

-- auto close paranthesis
imap('{', '{}<Left>')
imap('{<Space>', '<Esc>o{}<Left><CR><TAB><CR><Up><Right><Right>')

imap('(', '()<Left>')
imap('<', '<><Left>')
imap('\'', '\'\'<Left>')
imap('"', '""<Left>')
imap('[', '[]<Left>')
