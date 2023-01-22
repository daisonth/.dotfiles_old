require("bufferline").setup({
  options = {
    numbers = "ordinal",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Tree",
        highlight = "Directory",
        text_align = "center",
      },
    },
  },
})

vim.keymap.set("n","<C-b>", ":BufferLinePick<CR>")
vim.keymap.set("n","<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n","<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n","<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n","<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n","<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n","<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n","<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n","<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n","<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
