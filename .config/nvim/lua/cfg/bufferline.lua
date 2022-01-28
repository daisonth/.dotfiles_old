require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Tree",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}

nmap('<C-b>',':BufferLinePick<CR>')
