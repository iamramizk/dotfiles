return {
  "Bekaboo/dropbar.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local dropbar = require("dropbar")
    local sources = require("dropbar.sources")
    local utils = require("dropbar.utils")

    -- Custom source for path (filename)
    local custom_path = {
      get_symbols = function(bufnr, winid, cursor)
        local symbols = sources.path.get_symbols(bufnr, winid, cursor)
        if #symbols > 0 then
          local filename_symbol = symbols[#symbols]

          -- Append a space to the filename
          filename_symbol.name = filename_symbol.name .. " "
          -- Check if buffer is modified
          local is_modified = vim.bo[bufnr].modified

          if is_modified then
            filename_symbol.name_hl = "DropBarFileNameModified"
          else
            filename_symbol.name_hl = "DropBarFileName"
          end

          return { filename_symbol }
        end
        return {}
      end,
      shorten = false,
    }

    -- Custom fallback source that sets breadcrumb highlight group
    local lsp_ready = false

    -- Set lsp_ready true after delay once config loads
    vim.defer_fn(function()
      lsp_ready = true
    end, 3000)

    local custom_fallback = {
      get_symbols = function(bufnr, winid, cursor)
        if not lsp_ready then
          -- Return empty symbols until delay passes
          return {}
        end

        local fallback_syms = utils.source
          .fallback({
            sources.lsp,
            sources.treesitter,
          })
          .get_symbols(bufnr, winid, cursor)

        for _, sym in ipairs(fallback_syms) do
          sym.name_hl = "DropBarBreadcrumb"
        end

        return fallback_syms
      end,
      shorten = true,
    }
    --ORIGINAL
    -- local custom_fallback = {
    --   get_symbols = function(bufnr, winid, cursor)
    --     local fallback_syms = utils.source
    --       .fallback({
    --         sources.lsp,
    --         sources.treesitter,
    --       })
    --       .get_symbols(bufnr, winid, cursor)
    --
    --     -- Set highlight group for breadcrumbs only
    --     for _, sym in ipairs(fallback_syms) do
    --       sym.name_hl = "DropBarBreadcrumb"
    --     end
    --
    --     return fallback_syms
    --   end,
    --   shorten = true,
    -- }

    dropbar.setup({
      bar = {
        enable = function(buf, win)
          return vim.api.nvim_buf_is_valid(buf)
            and vim.api.nvim_win_is_valid(win)
            and vim.bo[buf].buftype == ""
            and vim.fn.win_gettype(win) == ""
            and vim.wo[win].winbar == ""
        end,
        sources = function(bufnr)
          return {
            custom_path, -- filename
            custom_fallback, -- breadcrumbs with custom highlight
          }
        end,
      },
    })
  end,
}
