M = {}
M.buildSystems = {
  ["C:/Users/KLM94141"] = "echo hello!",
  ["C:/Users/KLM94141/AppData/Local/nvim-data/site/pack/core/opt/nobs.nvim"] = "echo hello!!",
  ["abcdefg"] = {
    ["1"] = "nested value 1",
    ["2"] = "nested value 2",
    ["Nested table"] = {
      ["Nested Nested"] = "Nested Nested value"
    }
  }
}

function tableToJsonString(table, recursion)
  local content = ""
  local rbracket = ""
  if table == nil or table == {} then
    vim.notify("buildSystems table is empty")
    return
  end
  if recursion == nil then
    recursion = 1
    local lbracket = "["
    rbracket = "]"
    content = string.format("%s%s",string.rep("\t",recursion-1), lbracket)
  else
    recursion = recursion + 1
    local lbracket = "{"
    rbracket = "}"
    content = string.format("%s%s",string.rep("\t",recursion-1), lbracket)
  end
  
  local line = ""
  local indentation = string.rep("\t",recursion)

  for k,v in pairs(table) do
    if type(v) == "table" then
      content = string.format("%s\n%s\"%s\" :", content, string.rep("\t", recursion), k)
      line = tableToJsonString(v, recursion + 1)
    else
      line = string.format("%s\"%s\" : \"%s\",", indentation, k, v)
    end
    content = string.format("%s\n%s", content, line)
  end
  content = string.format("%s\n%s%s",content, string.rep("\t", recursion - 1), rbracket)
  return content
end

function readJsonFile(path)
  file = io.open(path, "r")
  return file:read("a")
end

content = tableToJsonString(M.buildSystems)
print("raw lines from lua:")
print(content)

file = io.open("test.json", "w")
file:write(content)
file:close()

content = readJsonFile("test.Json")
print("Lines file:")
print(content)
