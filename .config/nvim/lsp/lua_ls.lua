--- @type vim.lsp.Config
return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" }},
			worksapce = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
				},
			},
		},
	},
}
