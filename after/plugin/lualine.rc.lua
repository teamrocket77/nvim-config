local ok, lualine = pcall(require, 'lualine')
if (not ok) then
  print("Lualine is not installed")
  return
end

lualine.setup{
}
