local opts = { noremap = true, silent = true }
local lmap = vim.api.nvim_set_keymap
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'
lmap("n", "<leader>fg", "<Cmd>Telescope live_grep<cr>", opts)
lmap("n", "<leader>ff", "<Cmd>Telescope find_files<cr>", opts)

-- debug
lmap("n", "<space>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
lmap("n", "<space>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opts)
-- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
lmap("n", "<F9>", "<cmd>lua require'dap'.run_last()<cr>", opts)
lmap('n', '<F10>', '<cmd>lua require"user.dap.dap-util".reload_continue()<CR>', opts)
lmap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opts)
lmap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
lmap("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", opts)
lmap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opts)
lmap("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
lmap("n", "K", "<cmd>lua require'dapui'.eval()<cr>", opts)
