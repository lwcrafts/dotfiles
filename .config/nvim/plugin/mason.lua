require("vim-pack").add({
	{
		src = "williamboman/mason.nvim",
	},
	{
		src = "williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
			ensure_installed = {
				-- LSPs
				"lua_ls",
				"ts_ls",
				"tailwindcss",
				"pyright",
				-- Formatters
				-- "stylua",
				-- "swiftformat",
			},
		},
	},
})
