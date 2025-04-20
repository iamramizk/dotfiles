return {
  "Bekaboo/dropbar.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  -- event = "VeryLazy",
  event = { "BufWinEnter", "BufReadPost" },
  config = function()
    local dropbar = require("dropbar")
    local sources = require("dropbar.sources")
    local utils = require("dropbar.utils")

    -- 🔵 Workspace ready detection (LSP + fallback timeout)
    local lsp_ready = false

    local function wait_for_lsp_ready(bufnr)
      local timer = vim.loop.new_timer()

      vim.lsp.buf_request(
        bufnr,
        "textDocument/documentSymbol",
        { textDocument = vim.lsp.util.make_text_document_params() },
        function(err, result, ctx, config)
          if not err and result then
            lsp_ready = true
            timer:stop()
          end
        end
      )

      -- fallback timeout in case LSP misbehaves
      timer:start(3000, 0, function()
        lsp_ready = true
        timer:stop()
      end)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        wait_for_lsp_ready(bufnr)
      end,
    })

    -- 🔵 Custom source for path (filename)
    local custom_path = {
      get_symbols = function(bufnr, winid, cursor)
        local symbols = sources.path.get_symbols(bufnr, winid, cursor)
        if #symbols > 0 then
          local filename_symbol = symbols[#symbols]

          -- Append a space to filename
          filename_symbol.name = filename_symbol.name .. " "

          -- Check if buffer is modified
          if vim.bo[bufnr].modified then
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

    -- 🔵 Custom fallback source for breadcrumbs
    local custom_fallback = {
      get_symbols = function(bufnr, winid, cursor)
        if not lsp_ready then
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

    -- 🔵 Setup Dropbar
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
            custom_path,
            custom_fallback,
          }
        end,
      },
    })
  end,
}
