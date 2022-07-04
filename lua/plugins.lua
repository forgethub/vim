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
             use("nvim-telescope/telescope.nvim")
             use("nvim-treesitter/nvim-treesitter")
             use("preservim/nerdtree")
             use("hrsh7th/nvim-cmp")
             use("hrsh7th/cmp-path")
             use("hrsh7th/cmp-vsnip")
             use("hrsh7th/cmp-buffer")
             use("hrsh7th/cmp-nvim-lsp")
             -- use("hrsh7th/cmp-cmdline")
			 use({
				 "kylechui/nvim-surround",
				 config = function()
					 require("nvim-surround").setup({
						 -- Configuration here, or leave empty to use defaults
					 })
				 end
			 })

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
