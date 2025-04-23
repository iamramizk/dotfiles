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
    opts.options.disabled_filetypes.winbar = vim.list_extend(opts.options.disabled_filetypes.winbar or {}, {
      "noice",
      "man",
      "snacks_terminal",
      "snacks_dashboard",
      "help",
      "trouble",
    })

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
    opts.sections.lualine_b = {
      { "branch", icon = "" },
    }

    -- function to get parent paths (2)
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

    -- function to get python virtual path
    local function get_pyvenv()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        local name = vim.fn.fnamemodify(venv, ":t")
        return " " .. name
      end
      return ""
    end

    -- function to get column width
    local function width_gt(n)
      return function()
        return vim.o.columns > n
      end
    end
    -- root dir comp with width cond
    local root_dir = LazyVim.lualine.root_dir()
    root_dir.cond = width_gt(100)

    opts.sections.lualine_c = {
      {
        get_pyvenv,
        color = { fg = "#90CF5A" },
        cond = function()
          return vim.bo.filetype == "python"
        end,
      },
      root_dir,
      -- LazyVim.lualine.root_dir(),
      {
        two_parent_dirs,
        color = { fg = "#79809E" },
        cond = function()
          -- Hide when in terminal buffers or Snacks terminal
          if vim.bo.filetype == "snacks_terminal" then
            return false
          end
          return true
        end,
      },
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
    }

    opts.sections.lualine_x = {
      Snacks.profiler.status(),
      -- stylua: ignore
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = function() return { fg = Snacks.util.color("Statement") } end,
      },
      -- stylua: ignore
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = function() return { fg = Snacks.util.color("Constant") } end,
      },
      -- stylua: ignore
      {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
        color = function() return { fg = Snacks.util.color("Debug") } end,
      },
      -- stylua: ignore
      -- {
      --   require("lazy.status").updates,
      --   cond = require("lazy.status").has_updates,
      --   color = function() return { fg = Snacks.util.color("Special") } end,
      -- },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
      {
        "lsp_status",
        color = { fg = "#79809E" },
        symbols = {
          done = "",
        },
        cond = width_gt(100),
      },
    }

    opts.sections.lualine_y = {
      {
        "progress",
        cond = function()
          -- Hide when in terminal buffers or Snacks terminal
          if vim.bo.filetype == "snacks_terminal" then
            return false
          end
          return true
        end,
      },
    }
    opts.sections.lualine_z = {
      { "location", separator = { right = "" } },
    }
  end,
}
