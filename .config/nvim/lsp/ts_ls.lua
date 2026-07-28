---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	init_options = {
		preferences = {
			-- includeInlayParameterNameHints = "all",
			-- includeInlayVariableTypeHints = true,
		},
	},
}
