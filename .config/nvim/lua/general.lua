-- options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Disabled mouse mode.
opt.mouse = ""
opt.clipboard = "unnamedplus"

-- vim.o.linebreak = true

-- Completion
opt.completeopt = "menuone,noselect,noinsert"
opt.pumblend = 10
opt.pumheight = 15

-- Status line.
opt.laststatus = 3
opt.cmdheight = 0
opt.winborder = "rounded"

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 10
opt.sidescrolloff = 8
opt.wrap = false

opt.termguicolors = true


-- keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-a>", "gg<S-v>G")

--- New tabs
vim.keymap.set("n", "te", ":tabedit ", opts)
vim.keymap.set("n", "<tab>", ":tabnext<Return>", opts)
vim.keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
vim.keymap.set("n", "ss", ":split<Return>", opts)
vim.keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")
