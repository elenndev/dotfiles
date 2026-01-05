vim.keymap.set("n", "<leader>x", function()
	vim.diagnostic.setloclist()
	vim.cmd("lopen")
end, { desc = "buffer diagnostics" })
