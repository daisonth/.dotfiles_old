require('settings')
require('mappings')
require('plugins')

require('cfg/bufferline')
--require('cfg/lualine')
require('cfg/nvimTree')
--require('cfg/gruvbox')
require('cfg/catppuccin')
--require('cfg/neorg')
require('cfg/cmp')
require('cfg/treesitter')
require('cfg/fterm')
require('cfg/colorizer')

require'lspconfig'.html.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.intelephense.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.tsserver.setup{}
