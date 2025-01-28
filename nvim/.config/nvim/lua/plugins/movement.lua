local misc = require("utils.misc")

return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<leader>l", mode = { "n" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "<c-f>",
                mode = { "n" },
                misc.flash_search,
                desc = "Toggle Flash Search"
            },
        },
    },
}
