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

nmap("<C-b>", ":BufferLinePick<CR>")
nmap("<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
nmap("<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
nmap("<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
nmap("<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
nmap("<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
nmap("<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
nmap("<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
nmap("<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
nmap("<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
