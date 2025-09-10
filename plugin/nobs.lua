require("nobs")

vim.api.nvim_create_user_command(
  "CBS", function(opts)
    local cwd = vim.fn.expand("%:p:h")
    local cmd = opts.args
    require("nobs").createBuildSystem(cwd, cmd)
  end,
  { nargs = "+" }
)

vim.api.nvim_create_user_command(
  "RBS", function(opts)
    local cwd = vim.fn.expand("%:p:h")
    require("nobs").removeBuildSystem(cwd)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "GBS", function(opts)
    local cwd = vim.fn.expand("%:p:h")
    require("nobs").getBuildSystem(cwd, true)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  "EBS", function(opts)
    local cwd = vim.fn.expand("%:p:h")
    require("nobs").executeBuildSystem(cwd)
  end,
  { nargs = 0 }
)
