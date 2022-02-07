require('settings')
require('mappings')
require('plugins')

require('cfg/bufferline')
require('cfg/nvimTree')
require('cfg/catppuccin')
require('cfg/cmp')
require('cfg/treesitter')
require('cfg/fterm')
require('cfg/colorizer')
require('cfg/vimwiki')

require'lspconfig'.html.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.intelephense.setup{}
--require'lspconfig'.clangd.setup{}
require'lspconfig'.tsserver.setup{}
--local keybinds = require('lsp_config.keybinds')

require('lspconfig').clangd.setup {
  --      on_attach = keybinds.on_attach,
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            '--query-driver="/usr/local/opt/gcc-arm-none-eabi-8-2019-q3-update/bin/arm-none-eabi-gcc"'
        },
        filetypes = {"c", "cpp", "hpp", "objc", "objcpp"},
}

