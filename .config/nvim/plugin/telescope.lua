require("vim-pack").add({
	{ src = "nvim-lua/plenary.nvim", setup = false },
	{ src = "nvim-telescope/telescope-file-browser.nvim", setup = false },
	{
		src = "nvim-telescope/telescope.nvim",
		opts = function()
			local actions = require("telescope.actions")
			return {
				defaults = {
					theme = "dropdown",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
					},
					mappings = {
						["n"] = {
							q = actions.close,
						},
					},
				},
				extensions = {
					file_browser = {
						cwd = "%:p:h",
						path = "%:p:h",
						layout_config = { horizontal = { width = 100 } },
						initial_mode = "normal",
						previewer = false,
						grouped = true,
					},
				},
			}
		end,
		on_setup = function()
			local t = require("telescope")

			t.load_extension("file_browser")

			vim.keymap.set("n", ";f", "<cmd>Telescope find_files<cr>")
			vim.keymap.set("n", ";F", "<cmd>Telescope find_files hidden=true<cr>")
			vim.keymap.set("n", ";r", "<cmd>Telescope live_grep<cr>")
			vim.keymap.set("n", ";;", "<cmd>Telescope resume<cr>")
			vim.keymap.set("n", "sf", "<cmd>Telescope file_browser<cr>")
		end,
	},
})
