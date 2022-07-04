function OrgImports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end
-- 代码补全结束后自动导包
vim.api.nvim_command('autocmd BufWritePre *.go lua OrgImports(1000)')
-- 保存代码之前自动格式化
vim.api.nvim_command('autocmd BufWritePre *.go :lua vim.lsp.buf.format()')
