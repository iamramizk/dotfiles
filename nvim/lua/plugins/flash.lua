return {
  "folke/flash.nvim",
  keys = {
    {
      "H",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
