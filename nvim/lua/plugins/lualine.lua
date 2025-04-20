return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
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

    -- update icon in branch
    opts.sections.lualine_b = { { "branch", icon = "" } }

    -- remove navic from default lauline_c
    opts.sections.lualine_c = vim.list_slice(opts.sections.lualine_c, 1, 2)

    -- add parent paths to section c
    local function two_parent_dirs()
      local filepath = vim.fn.expand("%:p")
      if filepath == "" then
        return ""
      end
      local sep = package.config:sub(1, 1)
      local parts = vim.split(filepath, sep)
      local filtered = {}
      for _, part in ipairs(parts) do
        if part ~= "" then
          table.insert(filtered, part)
        end
      end

      local count = #filtered
      if count < 2 then
        return ""
      end

      local parents_count = math.min(2, count - 1)
      local start_index = count - parents_count
      local parent_dirs = {}
      for i = start_index, count - 1 do
        table.insert(parent_dirs, filtered[i])
      end

      local folder_icon = " " -- Nerd Font folder icon with trailing space
      return folder_icon .. table.concat(parent_dirs, sep)
    end
    table.insert(opts.sections.lualine_c, { two_parent_dirs, color = { fg = "#79809E" } })

    table.insert(opts.sections.lualine_x, {
      "lsp_status",
      color = { fg = "#79809E" },
      symbols = {
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        done = "",
        separator = " ",
      },
    })

    opts.sections.lualine_y = {
      { "progress" },
    }
    opts.sections.lualine_z = {
      { "location", separator = { right = "" } },
    }
  end,
}
