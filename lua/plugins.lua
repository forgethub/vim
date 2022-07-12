-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("正在安装Pakcer.nvim，请稍后...")
    paccker_bootstrap =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1", 
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("没有安装 packer.nvim")
    return
end

packer.startup(
    {
        function(use)
            -- 这里是安装插件的位置 TODO:
             use("wbthomason/packer.nvim")
             use("neovim/nvim-lspconfig")
             use("nvim-lua/plenary.nvim")
             -- Telescope
             use "nvim-telescope/telescope-live-grep-args.nvim"
             use {
                 "nvim-telescope/telescope.nvim",
                 tag = "nvim-0.6",
             }
             use {
                 'nvim-telescope/telescope-fzf-native.nvim',
                 run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
             }

             -- use {
             --   "nvim-telescope/telescope-frecency.nvim",
             --   requires = {"tami5/sqlite.lua"}   -- NOTE: need to install sqlite lib
             -- }
             use "nvim-telescope/telescope-ui-select.nvim"
             use "nvim-telescope/telescope-rg.nvim"
             -- use "MattesGroeger/vim-bookmarks"
             -- use "tom-anders/telescope-vim-bookmarks.nvim"
             use "nvim-telescope/telescope-dap.nvim"

             -- Treesittetr
             use {
                 "nvim-treesitter/nvim-treesitter",
                 run = ":TSUpdate",
                 commit = "44b7c8100269161e20d585f24bce322f6dcdf8d2",
             }
             use {
                 "nvim-treesitter/nvim-treesitter-textobjects",
                 commit = "c81382328ad47c154261d1528d7c921acad5eae5",
             } -- enhance texetobject selection
             use("preservim/nerdtree")
             use("hrsh7th/nvim-cmp")
             use("hrsh7th/cmp-path")
             use("hrsh7th/cmp-vsnip")
             use("hrsh7th/cmp-buffer")
             use("hrsh7th/cmp-nvim-lsp")
             use("voldikss/vim-translator")
             -- use("hrsh7th/cmp-cmdline")
			 use({
				 "kylechui/nvim-surround",
				 config = function()
					 require("nvim-surround").setup({
						 -- Configuration here, or leave empty to use defaults
					 })
				 end
			 })
			 use 'ray-x/go.nvim'
			 use 'ray-x/guihua.lua' -- recommanded if need floating window support
			 -- Debugger
			 use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
			 use {
				 "ravenxrz/nvim-dap",
			 }
			 use "theHamsta/nvim-dap-virtual-text"
			 use "rcarriga/nvim-dap-ui"
			 use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
			 use {
				 "sakhnik/nvim-gdb",
				 run = "./install.sh"
			 }
             -- snippets    
             use "L3MON4D3/LuaSnip" --snippet engine
             use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

            if paccker_bootstrap then
                packer.sync()
            end
        end,
        config = {
            -- 最大并发数
            max_jobs = 16,
            -- 自定义源
            git = {
                default_url_format = "https://mirror.ghproxy.com/https://github.com/%s"
            }
            -- display = {
            -- 使用浮动窗口显示
            --   open_fn = function()
            --     return require("packer.util").float({ border = "single" })
            --   end,
            -- },
        }
    }
)
