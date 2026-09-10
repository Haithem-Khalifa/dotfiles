return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- Setup parser install directory
    ts.setup()

    -- Automatically install and track your required languages
    local parsers = {
      "java", "cpp", "c", "html", "css", "javascript", "json", "lua", "vim", "vimdoc", "markdown"
    }
    ts.install(parsers)

    -- Enable Treesitter highlighting and indenting natively per buffer
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
