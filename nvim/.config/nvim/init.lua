vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

require("options")

require("keymaps")

-- require("lazy-bootstrap")
--
-- require("lazy-plugins")

require("config.vimpack")

require("config.treesitter")

require("config.lsp")


  require 'kickstart.plugins.debug'
  require 'kickstart.plugins.autopairs'
  require 'kickstart.plugins.neo-tree'
  require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

require("custom.plugins")
