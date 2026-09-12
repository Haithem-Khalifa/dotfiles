return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    opts = {
      enable_close = true,          -- Auto-close tags (e.g. <div> -> <div></div>)
      enable_rename = true,         -- Auto-rename matching tag when editing one side
      enable_close_on_slash = true, -- Auto-close when typing '</'
    },
  },
}
