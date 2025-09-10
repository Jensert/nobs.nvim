local M = {}

M.buildSystems = {}

function M.createBuildSystem(cwd, command)
  -- Check if parameters are correctly filled
  if cwd == nil and command == nil then
    vim.notify("createBuildSystem: directory and command are both nil", vim.log.levels.ERROR)
    return
  end
  if cwd == nil then
    vim.notify("createBuildSystem: directory is nil", vim.log.levels.ERROR)
    return
  end
  if command == nil then
    vim.notify("createBuildSystem: command is nil", vim.log.levels.ERROR)
    return
  end

  M.buildSystems[cwd] = command
  local message = string.format("createBuildSystem: new command created for '%s'", cwd)
  vim.notify(message)
end

function M.removeBuildSystem(cwd)
  if cwd == nil then
    vim.notify("removeBuildSystem: directory is nil")
    return
  end

  if M.buildSystems[cwd] == nil then
    local message = string.format("removeBuildSystem: no command found for '%s'", cwd)
    vim.notify(message)
    return
  end

  M.buildSystems[cwd] = nil
  local message = string.format("removeBuildSystem: command for directory '%s' removed", cwd)
  vim.notify(message)
end

function M.getBuildSystem(cwd, notify)
  if cwd == nil then
    vim.notify("getBuildSystem: directory is nil")
    return
  end
  local command = M.buildSystems[cwd]
  if command == nil then
    return
  end
  local message = string.format("getBuildSystem: build system found '%s'", command)
  if notify == nil or notify == false then
    return command
  end
  vim.notify(message)
  return command
end

function M.executeBuildSystem(cwd)
  local command = M.getBuildSystem(cwd)
  if command == nil then
    local message = string.format("executeBuildSystem: no command found for '%s'", cwd)
    vim.notify(message)
    return
  end
  local message = string.format("Executing command: '%s'", command)
  vim.notify(message)
  vim.cmd("rightbelow vsplit | term " .. command)
end

function M.hello_world()
  print("Hello World!")
end
return M
