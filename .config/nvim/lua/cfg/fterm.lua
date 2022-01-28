require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
    blend = 10
})

nmap('<F1>',":lua require('FTerm').toggle()<CR>")
tmap('<F1>',"<C-\\><C-n>:lua require('FTerm').toggle()<CR>")
