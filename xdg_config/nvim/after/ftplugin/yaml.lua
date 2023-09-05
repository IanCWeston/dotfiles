vim.keymap.set("n", "<leader>A", function()
	vim.cmd("LspStop")

	if vim.bo.filetype == "yaml.ansible" then
		vim.opt.filetype = "yaml"
	else
		vim.opt.filetype = "yaml.ansible"
	end

	vim.cmd("LspRestart")
end, { desc = "Ansible filetype toggle" })
