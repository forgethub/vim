vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opts = { noremap = true, silent = true }
local lmap = vim.api.nvim_set_keymap
lmap("n", "<leader>fg", "<Cmd>Telescope live_grep<cr>", opts)
lmap("n", "<leader>ff", "<Cmd>Telescope find_files<cr>", opts)
