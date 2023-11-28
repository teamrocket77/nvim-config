local config = {
    cmd = {
	    -- uses wrapper script
	    '/Users/vincentcradler/repos/tools/jdtls/bin/jdtls'
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'Main.java'}, { upward = true })[1]),

    settings = (function()
      if vim.env.JAVA_HOME == nil or vim.env.JAVA_HOME == '' then
        return { }
      else
        return {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = vim.env.JAVA_HOME .. "/"
                  },
                }
              }
            }
          }
      end
    end)(),

    bundles = { },

    -- for _, jar_pattern in ipairs(jar_patterns) do
    --   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')
    --     table.insert(bundles, bundle)
    --   end
    -- end
    -- init_options = {
    --   bundles = {

    --   }
    -- },
}

local ok, jdtls = pcall(require, 'jdtls')
if not ok
  then
    print("jdtls is not installed")
    print("Java Home should be set correctly")
    return
  end
jdtls.start_or_attach(
	config
)
