--------------------------------------------------------------------------------
-- Per-server LSP actions
--------------------------------------------------------------------------------

local M = {}

-- Real code action rather than a text transform, so it honours the server's own
-- importModuleSpecifierPreference. Runs on demand only; prettier still owns save.
function M.organize_imports()
	vim.lsp.buf.code_action({
		context = {
			only = { "source.organizeImports" },
			diagnostics = {},
		},
		apply = true,
	})
end

function M.switch_source_header(client, bufnr)
	local params = vim.lsp.util.make_text_document_params(bufnr)

	client:request("textDocument/switchSourceHeader", params, function(err, result)
		if err then
			vim.notify(tostring(err), vim.log.levels.ERROR)
			return
		end
		if not result then
			vim.notify("No matching source/header file", vim.log.levels.WARN)
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

return M
