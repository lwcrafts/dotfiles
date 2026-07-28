local opts = {
	keymap = { preset = "enter" },
	snippets = { preset = "luasnip" },
	cmdline = { enabled = false },
	-- sources = {
	-- 	default = function()
	-- 		local sources = { "lsp", "buffer" }
	-- 		local ok, node = pcall(vim.treesitter.get_node)
	--
	-- 		if ok and node then
	-- 			if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
	-- 				table.insert(sources, "path")
	-- 			end
	-- 			if node:type() ~= "string" then
	-- 				table.insert(sources, "snippets")
	-- 			end
	-- 		end
	--
	-- 		return sources
	-- 	end,
	-- },
	-- completion = {
	-- 	list = { selection = { preselect = false } },
	-- 	documentation = {
	-- 		auto_show = true,
	-- 		auto_show_delay_ms = 200,
	-- 	},
	-- 	menu = {
	-- 		scrollbar = false,
	-- 		draw = {
	-- 			gap = 2,
	-- 		},
	-- 	},
	-- },
}

require("vim-pack").add({
	{ src = "saghen/blink.lib", setup = false },
	{
		src = "L3MON4D3/LuaSnip",
		module_name = "luasnip",
		on_setup = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})
		end,
	},
	{
		src = "saghen/blink.cmp",
		setup = false,
		on_setup = function()
			local cmp = require("blink.cmp")
			cmp.build():pwait()
			cmp.setup(opts)
		end,
	},
})
