vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/folke/neodev.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
})

require("nvim-web-devicons").setup({ default = true })
require("neodev").setup()
