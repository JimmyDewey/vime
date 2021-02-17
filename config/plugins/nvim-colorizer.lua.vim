if has('termguicolors')
    set termguicolors
else
    finish
endif

lua << EOF
if jit ~= nil then
  require'colorizer'.setup()
end

EOF
