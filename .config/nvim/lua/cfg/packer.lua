return require("packer").startup({
	function()
		use("wbthomason/packer.nvim")

		use("kyazdani42/nvim-tree.lua")
		use("kyazdani42/nvim-web-devicons")
		use("akinsho/bufferline.nvim")
		use("lukas-reineke/indent-blankline.nvim")
		use("numToStr/FTerm.nvim")
		use("norcalli/nvim-colorizer.lua")
		use("nvim-lua/plenary.nvim")
		use("nvim-telescope/telescope.nvim")

		--	use({ "catppuccin/nvim", as = "catppuccin" })
		--	use("eddyekofo94/gruvbox-flat.nvim")
		--	use("bluz71/vim-moonfly-colors")
		use("luisiacc/gruvbox-baby")
		--	use("folke/tokyonight.nvim")
		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("spellsitter").setup()
			end,
		})

		use({
			"xeluxee/competitest.nvim",
			requires = "MunifTanjim/nui.nvim",
			config = function()
				require("competitest").setup()
			end,
		})

		use({
			"goolord/alpha-nvim",
			config = function()
				local alpha = require("alpha")
				local dashboard = require("alpha.themes.dashboard")
				dashboard.section.header.val = {
					[[                               __                ]],
					[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
					[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
					[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
					[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
					[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
				}
				dashboard.section.buttons.val = {
					dashboard.button("N", "  New file", "<cmd>ene <CR>"),
					dashboard.button("F", "  Find file", "<cmd>Telescope find_files<CR>"),
					dashboard.button("R", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
					dashboard.button("V", "📓 Vimwiki", "<cmd>VimwikiIndex<CR>"),
					dashboard.button("P", "📦 Packersync", "<cmd>PackerSync<CR>"),
					dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
				}
				dashboard.config.opts.noautocmd = true

				vim.cmd([[autocmd User AlphaReady echo 'ready']])

				alpha.setup(dashboard.config)
			end,
		})
		use({ "ellisonleao/glow.nvim", branch = "main" })

		use("jose-elias-alvarez/null-ls.nvim")

		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")

		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("saadparwaiz1/cmp_luasnip")
		use("onsails/lspkind-nvim")

		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		use("rafamadriz/friendly-snippets")
		use("L3MON4D3/LuaSnip")

		use("vimwiki/vimwiki")
	end,

	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
			prompt_border = "single",
		},
		git = {
			clone_timeout = 600, -- Timeout, in seconds, for git clones
		},
		auto_clean = true,
		compile_on_sync = true,
	},
})
