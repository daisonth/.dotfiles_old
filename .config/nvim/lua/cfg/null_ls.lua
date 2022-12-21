local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		-- require("null-ls").builtins.formatting.pret,
		-- require("null-ls").builtins.formatting.pint,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.astyle.with({ extra_args = { "--indent=tab" } }),
		-- require("null-ls").builtins.diagnostics.cppcheck,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.tidy,
	},
	-- on_attach = function(client)
	-- 	if client.server_capabilities.document_formatting then
	-- 		vim.cmd([[
	--            augroup LspFormatting
	--                autocmd! * <buffer>
	--                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	--            augroup END
	--            ]])
	-- 	end
	-- end,

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
})
