local colorscheme = "kanagawa"
-- local colorscheme = "tokyonight"
-- local colorscheme = "nightfox"


-- if colorscheme == "tokyonight" then
--   vim.g.tokyonight_italic_keywords = true
--   vim.api.nvim_exec(
--     [[
--     augroup MyColors
--       autocmd!
--       autocmd ColorScheme * highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00
--     augroup END
--     ]],
--     false
--   )
-- end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
