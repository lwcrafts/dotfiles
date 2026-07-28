-- Disable lsp
local disabled = {}

vim.g.inlay_hints = true

local methods = vim.lsp.protocol.Methods

local M = {}

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	--- @param lhs string
	--- @param rhs string|function
	--- @param opts string |vim.keymap.set.Opts
	--- @param mode? string|string[]
	local function keymap(lhs, rhs, opts, mode)
		mode = mode or "n"
		local keymap_opts
		if type(opts) == "string" then
			keymap_opts = { desc = opts, buffer = bufnr }
		else
			keymap_opts = vim.tbl_extend("force", opts, { buffer = bufnr })
		end
		vim.keymap.set(mode, lhs, rhs, keymap_opts)
	end

	keymap("]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, "Next diagnostic")
	keymap("[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, "Previous diagnostic")
	keymap("]e", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
	end, "Next error")
	keymap("[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")

	if client:supports_method(methods.textDocument_hover, bufnr) then
		keymap("K", function()
			vim.lsp.buf.hover({ silent = true })
		end, "Hover documentation")
	end

	if client:supports_method(methods.textDocument_references) then
		keymap("grr", "<cmd>Telescope lsp_references<cr>", "vim.lsp.buf.references()")
	end
	if client:supports_method(methods.textDocument_definition) then
		keymap("gd", "<cmd>Telescope lsp_definitions<cr>", "Go to definition")
		keymap("gD", "<cmd>Telescope lsp_type_definitions<cr>", "Peek definition")
	end
	if client:supports_method(methods.textDocument_signatureHelp, bufnr) then
		keymap("<C-i>", function()
			if require("blink.cmp.completion.windows.menu").win:is_open() then
				require("blink.cmp").hide()
			end
			vim.lsp.buf.signature_help()
		end, "Signature help", "i")
	end

	if client:supports_method(methods.textDocument_codeAction) then
		keymap("<leader>ca", function()
			vim.lsp.buf.code_action()
		end, "Code action")
	end

	if client:supports_method(methods.textDocument_inlayHint, bufnr) then
		local inlay_hints_group = vim.api.nvim_create_augroup("mariasolos/toggle_inlay_hints", { clear = false })

		if vim.g.inlay_hints then
			vim.defer_fn(function()
				local mode = vim.api.nvim_get_mode().mode
				vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
			end, 500)
		end

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = inlay_hints_group,
			desc = "Enable inlay hints",
			buffer = bufnr,
			callback = function()
				if vim.g.inlay_hints then
					vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				end
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = inlay_hints_group,
			desc = "Diable inlay hints",
			buffer = bufnr,
			callback = function()
				if vim.g.inlay_hints then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end,
		})
	end
end

local register_capability = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	on_attach(client, vim.api.nvim_get_current_buf())

	return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		on_attach(client, args.buf)
	end,
})

-- Set up LSP services.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		--配置capabilities
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
		})

		local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
		local servers = vim.iter(vim.fn.globpath(lsp_dir, "*.lua", true, true))
			:map(function(file)
				return vim.fn.fnamemodify(file, ":t:r")
			end)
			:filter(function(name)
				return not disabled[name]
			end)
			:totable()

		vim.lsp.enable(servers)
	end,
})

return M
