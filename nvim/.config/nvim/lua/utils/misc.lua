return {
    flash_search = function()
        vim.api.nvim_input("/")
        require("flash").toggle()
        vim.api.nvim_create_autocmd("CmdlineLeave", {
            pattern = "/",
            callback = function()
                require("flash").toggle()
            end,
            once = true,
        })
    end,
}

