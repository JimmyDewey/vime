" 设置runner，可以使用floaterm或者外部的terminal等
" https://github.com/skywind3000/asyncrun.vim/wiki/Customize-Runner
" https://github.com/voldikss/vim-floaterm#asynctasksvim
let g:asyncrun_open = 6

noremap <silent><f5> :AsyncTask file-run<cr>
noremap <silent><f9> :AsyncTask file-build<cr>
noremap <leader>lb :AsyncTask file-build<cr>
noremap <leader>lr :AsyncTask file-run<cr>

noremap <silent><f6> :AsyncTask project-run<cr>
noremap <silent><f7> :AsyncTask project-build<cr>
