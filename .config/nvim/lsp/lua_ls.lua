--- brew install lua-language-server

local library = vim.api.nvim_get_runtime_file("", true)
table.insert(library, "${3rd}/luv/library")

---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc", "stylua.toml" }, ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
			},
			-- use stylua
			format = { enable = false },
			workspace = {
				checkThirdParty = false,
				library = library,
			},
		},
	},
}
