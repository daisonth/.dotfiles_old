require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.tidy,
		require("null-ls").builtins.formatting.black,
		--		require("null-ls").builtins.formatting.astyle.with({ extra_args = { "--indent=tab" } }),
		--		require("null-ls").builtins.diagnostics.cppcheck,
		require("null-ls").builtins.completion.spell,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
