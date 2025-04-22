return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    local icons = LazyVim.config.icons
    opts.options = opts.options or {}
    opts.options.globalstatus = true
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    opts.winbar = {
      lualine_b = {
        {
          "filetype",
          colored = true,
          icon_only = true,
          padding = { left = 1, right = 0 },
          separator = "",
          color = { bg = "NONE" },
        },
        {
          -- Custom filename component to control trailing space manually
          function()
            local name = vim.fn.expand("%:t") -- get filename only
            local modified = vim.bo.modified
            if modified then
              return name
            else
              return name .. ""
            end
          end,
          color = function()
            if vim.bo.modified then
              return { fg = "#FF9856", bg = "NONE" }
            else
              return { fg = "#FFFFFF", bg = "NONE" }
            end
          end,
          separator = "",
          padding = { left = 0, right = 1 }, -- no padding here
        },
        -- {
        --   "filename",
        --   symbols = { modified = "" },
        --   color = function()
        --     local modified = vim.bo.modified
        --     if modified then
        --       return { fg = "#FF9856", bg = "NONE" }
        --     else
        --       return { fg = "#FFFFFF", bg = "NONE" }
        --     end
        --   end,
        --   padding = { left = 0, right = 1 },
        --   separator = "",
        -- },
      },
      -- Add breadcrumbs
      lualine_c = {
        {
          "navic",
          separator = { left = "" },
        },
      },
    }
    -- make winbar persistent
    opts.inactive_winbar = opts.winbar
    opts.options.disabled_filetypes.winbar =
      vim.list_extend(opts.options.disabled_filetypes.winbar or {}, { "noice", "man" })

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
    opts.sections.lualine_c = {
      LazyVim.lualine.root_dir(),
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { two_parent_dirs, color = { fg = "#79809E" } },
    }

    table.insert(opts.sections.lualine_x, {
      "lsp_status",
      color = { fg = "#79809E" },
      symbols = {
        done = "",
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
