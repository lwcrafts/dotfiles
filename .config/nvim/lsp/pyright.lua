---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly", -- 仅诊断当前打开的文件，极大节省大型项目的 CPU 占用
				typeCheckingMode = "basic", -- 校验级别: "off" | "basic" | "strict"
				-- 智能推导与补全辅助
				autoImportCompletions = true, -- 补全未导入的模块时自动插入 import 语句
				indexing = true, -- 开启第三方库/项目索引，大幅提升跳转速度
			},
		},
	},
}
