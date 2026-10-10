return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Optional but highly recommended for Neovim Lua development:
		-- provides completion, docs, and signature help for the vim API
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		require("mason").setup()

		-- Ensure Mason downloads your language servers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua Language Server
				"clangd", -- C / C++
				"html", -- HTML
				"cssls", -- CSS
				"ts_ls", -- JavaScript / TypeScript
				"jdtls", -- Java
				"emmet_language_server",
				"pyright", -- Python
			},
		})

		-- Global keymaps mapped natively on LspAttach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		-- Autocompletion capabilities from cmp_nvim_lsp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Standard servers without custom settings
		local servers = { "clangd", "html", "cssls", "ts_ls", "emmet_language_server", "pyright" }
		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
			})
			vim.lsp.enable(server)
		end

		-- Dedicated Lua LSP setup with Neovim API awareness & capabilities
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")
	end,
}
