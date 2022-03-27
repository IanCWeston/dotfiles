local filetype_status_ok, filetype = pcall(require, "filetype")
if not filetype_status_ok then
  return
end

require("filetype").setup({
    overrides = {
        extensions = {
            -- add ansible lsp support
            yml = "yaml.ansible"
        }
    }
})
