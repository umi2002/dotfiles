local misc = require("utils.misc")

vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

require("flash").setup({})

vim.keymap.set("n", "<leader>l", function()
	require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set("n", "<c-f>", misc.flash_search, { desc = "Toggle Flash Search" })
