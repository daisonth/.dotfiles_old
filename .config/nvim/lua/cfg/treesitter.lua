require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			-- ["foo.bar"] = "Identifier",
		},
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	ensure_installed = { "c", "cpp", "javascript", "python", "lua", "css", "scss", "html", "php", "bash" },
	-- ensure_installed = {"javascript", "python", "lua", "css", "scss", "html", "php", "bash"},

	indent = {
		enable = true,
	},
})

--vim.o.foldmethod = "expr"
--vim.o.foldexpr = "nvim_treesitter#foldexpr()"
