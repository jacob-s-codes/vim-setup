-- Bootstrap lazy.nvim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {desc = 'Exit terminal mode'})
vim.keymap.set('n', '<F5>', ":w<CR>:!python3 '%'<CR>", { desc = 'Run Python file' })
vim.keymap.set('n', '<leader>t', function()
  vim.cmd("split | term")
  vim.cmd("resize 15")
end, { desc = 'Open terminal at bottom' })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.cmd.colorscheme("catppuccin")
local plugins ={
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000},
	{
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    	}
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- Required
      "sindrets/diffview.nvim",        -- Optional - Adds great diff views
      "nvim-telescope/telescope.nvim", -- Optional
    },
    config = function()
      require("neogit").setup({
        kind = "vsplit",
      })
    end
  },
  -- Add this inside your local plugins = { ... } table
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font installed on your system for icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Optional: Map it to a quick shortcut like Ctrl + n
      vim.keymap.set('n', '<C-n>', ':Neotree toggle left<CR>', { silent = true })
    end
  }
}
local opts = {}

require("lazy").setup(plugins, opts)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

