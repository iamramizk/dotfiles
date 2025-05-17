return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = opts.completion or {}
      opts.completion.ghost_text = opts.completion.ghost_text or {}
      opts.completion.ghost_text.enabled = false -- disable ghost text preview

      -- Configure completion menu border
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.menu.border = "rounded"
      opts.completion.menu.draw = opts.completion.menu.draw or {}
      opts.completion.menu.draw.gap = 2

      -- Configure documentation window border
      opts.completion.documentation = opts.completion.documentation or {}
      opts.completion.documentation.auto_show = true
      opts.completion.documentation.auto_show_delay_ms = 200
      opts.completion.documentation.window = opts.completion.documentation.window or {}
      opts.completion.documentation.window.border = "rounded"

      -- Disable preselect and auto insert of first suggestion
      opts.completion.list = opts.completion.list or {}
      opts.completion.list.selection = {
        preselect = false,
        auto_insert = false,
      }

      return opts
    end,
  },
}
