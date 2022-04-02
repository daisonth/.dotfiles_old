require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.autopep8,
		require("null-ls").builtins.formatting.astyle.with({ extra_args = { "--indent=tab" } }),
		require("null-ls").builtins.diagnostics.cppcheck,
		require("null-ls").builtins.completion.spell,
	},
})
