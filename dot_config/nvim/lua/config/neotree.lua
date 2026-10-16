local M = {}

local kn_l_map = require("keymappings").kn_l_map

function M.setup()
  -- Use only the modern :Neotree command set.
  vim.g.neo_tree_remove_legacy_commands = 1

  require("neo-tree").setup({
    -- Close Neovim if the tree is the last window (parity with old NERDTree autocmd).
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        -- Show dotfiles (you had NERDTreeShowHidden = 1).
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { ".git", ".DS_Store", "node_modules" },
      },
      -- Reveal/highlight the current buffer in the tree (parity with old SyncTree).
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 31, -- matched old NERDTreeWinSize.
      mappings = {
        -- Don't let <space> inside the tree shadow your leader key.
        ["<space>"] = "none",
      },
    },
  })

  -- <leader>t toggles the tree and reveals the current file (replaces :NERDTreeFocus).
  kn_l_map("t", ":Neotree toggle reveal<cr>")
end

return M
