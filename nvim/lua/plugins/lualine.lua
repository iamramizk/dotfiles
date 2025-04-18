return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- opts.options.component_separators = ""
    opts.options.section_separators = { left = "", right = "" }

    -- Customize lualine_a section
    opts.sections.lualine_a = {
      {
        function()
          return "󱐋"
        end,
        separator = { left = "", right = "" },
      },
    }

    -- remove navic from default lauline_c
    opts.sections.lualine_c = vim.list_slice(opts.sections.lualine_c, 1, 4)

    opts.sections.lualine_y = {
      { "progress" },
    }
    opts.sections.lualine_z = {
      { "location", separator = { right = "" } },
    }
  end,
}
