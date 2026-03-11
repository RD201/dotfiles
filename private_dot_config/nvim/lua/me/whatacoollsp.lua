local client_id = vim.lsp.start({
	name = "whatacoollps",
	cmd = { "/home/drih/me/whatacoollsp/main" },
})

if client_id == nil then
	vim.notify("[whatacoollsp] client not configured.")
else
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			vim.lsp.buf_attach_client(0, client_id)
		end,
	})
end
