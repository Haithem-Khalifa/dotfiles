return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    -- Ensure Mason downloads your language servers
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", -- C / C++
        "html",   -- HTML
        "cssls",  -- CSS
        "ts_ls",  -- JavaScript / TypeScript
        "jdtls",  -- Java
        "emmet_language_server",
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

    -- Servers to configure and enable via native Neovim 0.12 API
    local servers = { "clangd", "html", "cssls", "ts_ls", "emmet_language_server" }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
      vim.lsp.enable(server)
    end
  end,
}
