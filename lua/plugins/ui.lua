local function open_oil_sidebar()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "oil" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  vim.cmd("topleft vsplit")
  vim.cmd("vertical resize 35")
  require("oil").open()
end

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
      { "<leader>e", open_oil_sidebar, desc = "Explorer (Oil Sidebar)" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.always_show_bufferline = true
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icon = false
      opts.options.separator_style = "slant"
    end,
  },
}
