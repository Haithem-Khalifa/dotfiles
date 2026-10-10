return {
	-- 1. In-buffer rendering (pretty tables, checkboxes, headers, callouts)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim", -- or nvim-tree/nvim-web-devicons
		},
		opts = {
			heading = {
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			bullet = {
				icons = { "•", "○", "◆", "◇" },
			},
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰄵 " },
			},
		},
		keys = {
			{ "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle In-buffer Markdown Render" },
		},
	},

	-- 2. Live browser preview with sync scrolling
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Browser Markdown Preview" },
		},
		config = function()
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_theme = "dark"
		end,
	},
}
