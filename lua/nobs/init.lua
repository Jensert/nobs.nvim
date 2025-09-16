local M = {}

function M.writeBuildSystemToFile(table, filePath)
  local content = vim.json.encode(table)
  local file = io.open(filePath, "w")
  if file == nil then
    vim.notify("Failed opening file: " .. filePath)
  end
  if content ~= nil and file ~= nil then
    file:write(content)
    file:flush()
    file:close()
  else
    vim.notify("Failed writing file")
  end
end

function M.readBuildSystemFromFile(filePath)
  local file = io.open(filePath, "r")
  if file ~= nil then
    local content = file:read("a")
    file:close()
    return vim.json.decode(content, { escape_slash = true } )
  end
end

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

  M.buildSystems[cwd] = command -- save command to the table

  local message = string.format("createBuildSystem: new command created for '%s'", cwd)
  vim.notify(message)
  M.writeBuildSystemToFile(M.buildSystems, M.pluginData) -- save plugin table to data folder
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


  M.writeBuildSystemToFile(M.buildSystems, M.pluginData) -- save plugin table to data folder
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

function M.toggleBuildSystem(cwd)
  local command = M.getBuildSystem(cwd, false)
  if command == nil then
    vim.ui.input({ prompt = "No command found for \'"..cwd.. "\'\nPlease enter command: " },
      function(input)
        if input ~= nil then
          vim.notify("\n")
          M.createBuildSystem(cwd, input)
        end
      end
    )
  else
    M.executeBuildSystem(cwd)
  end
end

M.pluginDataDirectory = vim.fn.stdpath("data") .. "\\nobs.nvim\\"
M.pluginData = M.pluginDataDirectory .. "data.json"

if vim.fn.isdirectory(M.pluginDataDirectory) == 0 then
  vim.notify("Nobs data directory does not exist yet, creating one now at: " .. M.pluginDataDirectory)
  vim.fn.mkdir(M.pluginDataDirectory)
end

M.buildSystems = M.readBuildSystemFromFile(M.pluginData)
if M.buildSystems == nil then
  M.buildSystems = {}
end

return M
