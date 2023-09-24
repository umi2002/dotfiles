local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local lsp_attach = function()
    local opts = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set("n", "<leader>tt", function()
        require("trouble").open()
    end)
    vim.keymap.set("n", "<leader>tw", function()
        require("trouble").open("workspace_diagnostics")
    end)
    vim.keymap.set("n", "<leader>td", function()
        require("trouble").open("document_diagnostics")
    end)
    vim.keymap.set("n", "<leader>tq", function()
        require("trouble").open("quickfix")
    end)
    vim.keymap.set("n", "<leader>tl", function()
        require("trouble").open("loclist")
    end)
    vim.keymap.set("n", "gR", function()
        require("trouble").open("lsp_references")
    end)
    vim.keymap.set("n", "<leader>df", "<CMD> FzfLua lsp_definitions  <CR>", opts)
    vim.keymap.set("n", "<leader>rf", "<CMD> FzfLua lsp_references  <CR>", opts)
    vim.keymap.set("n", "<leader>rc", "<CMD> lua require 'jdtls'.test_class()<CR>", opts)
    vim.keymap.set("n", "<leader>rm", "<CMD> lua require 'jdtls'.test_nearest_method()<CR>", opts)

    require("jdtls").setup_dap({})
    require("jdtls.dap").setup_dap_main_class_configs()
end

local mason_path = "/home/umi/.local/share/nvim/mason/packages/"

local launcher_path = vim.fn.glob(mason_path .. "jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
if #launcher_path == 0 then
    launcher_path = vim.fn.glob(mason_path .. "jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1, 1)[1]
end

local bundles = {}
vim.list_extend(bundles, vim.fn.glob(mason_path .. "java-test/extension/server/*.jar", 1, 1))

vim.list_extend(
    bundles,
    vim.fn.glob(mason_path .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1, 1)
)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    on_attach = lsp_attach,

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    cmd = {

        "/usr/lib/jvm/java-17-openjdk/bin/java", -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        launcher_path,
        "-configuration",
        mason_path .. "jdtls/config_linux",

        "-data",
        workspace_dir,
    },

    settings = {
        java = {
            runtimes = {
                { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
            },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = bundles,
    },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
require("dap.ext.vscode").load_launchjs()
