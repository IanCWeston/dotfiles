local ts = vim.treesitter

---@param node object
---@param replacementText string
local function replaceNodeText(node, replacementText)
  local startRow, startCol, endRow, endCol = node:range()
  local lines = vim.split(replacementText, "\n")
  vim.api.nvim_buf_set_text(0, startRow, startCol, endRow, endCol, lines)
end

-- auto-convert string to f-string and back
local function pythonFStr()
  local node = ts.get_node()
  if not node then
    return
  end

  local strNode
  if node:type() == "string" then
    strNode = node
  elseif node:type():find("^string_") then
    strNode = node:parent()
  elseif node:type() == "escape_sequence" then
    strNode = node:parent():parent()
  else
    return
  end

  local text = ts.get_node_text(strNode, 0)
  local isFString = text:find("^f")
  local hasBraces = text:find("{%w.-}")

  if not isFString and hasBraces then
    text = "f" .. text
    replaceNodeText(strNode, text)
  elseif isFString and not hasBraces then
    text = text:sub(2)
    replaceNodeText(strNode, text)
  end
end

local _python_fstrings = vim.api.nvim_create_augroup("_python_fstrings", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    pythonFStr()
  end,
  group = _python_fstrings,
})
