vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_side = 'bottom'
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_highlight_opened_files = 0
vim.g.nvim_tree_icon_padding = ' '
nmap('f4',':NvimTreeToggle<CR>')
--nmap('f3',':NvimTreeFindFile<CR>')

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup { 
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  view = {
    width = 40,
    height = 30,
    hide_root_folder = false,
    side = 'right',
    auto_resize = true,
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  }
}

