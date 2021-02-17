if has('termguicolors')
    set termguicolors
else
    finish
endif

lua << EOF
# in case that neovim don't have jit inside
if jit ~= nil then
  require'colorizer'.setup()
end

EOF
