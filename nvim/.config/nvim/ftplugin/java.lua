local jdtls = require("jdtls")
local home = os.getenv("HOME")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_os = mason_path .. "/config_linux"
local lombok_jar = home .. "/.local/share/java/lombok.jar"

-- Locate Java Debug Adapter bundles from Mason
local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"
local bundles = {
  vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.level=ALL",
    "-Xmx2G",
    "-javaagent:" .. lombok_jar,
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", config_os,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  init_options = {
    bundles = bundles,
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-25",
            path = vim.fn.resolve(vim.fn.exepath("java") .. "/../../"),
            default = true,
          },
        },
      },
    },
  },
}

-- Setup DAP integration when JDTLS attaches
config.on_attach = function(client, bufnr)
  pcall(require("jdtls").setup_dap, { hotcodereplace = "auto" })
  pcall(require("jdtls.dap").setup_dap_main_class_configs)
end

-- Java refactoring keymaps
local opts = { silent = true, buffer = true }
vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)

jdtls.start_or_attach(config)
