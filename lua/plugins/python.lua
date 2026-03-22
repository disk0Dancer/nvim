return {
  {
    "benomahony/uv.nvim",
    ft = "python",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      picker_integration = true,
      keymaps = {
        prefix = "<leader>u",
      },
    },
  },
}
