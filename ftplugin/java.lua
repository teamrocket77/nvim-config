local config = {
    cmd = {'/Users/vincentcradler/repos/tools/jdtls/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'Main.java'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
