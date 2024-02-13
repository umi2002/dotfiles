return {
	{
        "nvim-tree/nvim-web-devicons",
        opts = {
            default = true,
        },
    },
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	},
}
