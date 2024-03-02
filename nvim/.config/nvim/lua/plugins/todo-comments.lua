return {
  "folke/todo-comments.nvim",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    todo_comments.setup {
      signs = false,
    }
  end,
}
