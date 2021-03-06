set timeoutlen=300
let g:maplocalleader = ','
nnoremap <silent> [ :<c-u>WhichKey '['<CR>

call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" Define prefix dictionary
let g:which_key_map =  {}

" Second level dictionaries:
" 'name' is a special field. It will define the name of the group, e.g., leader-f is the \"+file\" group.
" Unnamed groups will show a default empty string.

" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.

let g:which_key_map.f = { 'name' : '+file' }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'

nnoremap <silent> <leader>fd :e $MYVIMRC<CR>
let g:which_key_map.f.d = 'open-vimrc'

nnoremap <silent> <leader>oq  :copen<CR>
nnoremap <silent> <leader>ol  :lopen<CR>
let g:which_key_map.o = {
      \ 'name' : '+open',
      \ 'q' : 'open-quickfix'    ,
      \ 'l' : 'open-locationlist',
      \ }

" =======================================================
" Create menus not based on existing mappings:
" =======================================================
" let g:which_key_map.b = {
"       \ 'name' : '+buffer' ,
"       \ '1' : ['b1'        , 'buffer 1']        ,
"       \ '2' : ['b2'        , 'buffer 2']        ,
"       \ 'd' : ['bd'        , 'delete-buffer']   ,
"       \ 'f' : ['Format'    , 'buffer format']   ,
"       \ 'h' : ['Startify'  , 'home-buffer']     ,
"       \ 'l' : ['blast'     , 'last-buffer']     ,
"       \ 'n' : ['bnext'     , 'next-buffer']     ,
"       \ 'p' : ['bprevious' , 'previous-buffer'] ,
"       \ '?' : ['Buffers'   , 'fzf-buffer']      ,
"       \ }

let g:which_key_map.l = {
      \ 'name' : '+lsp',
      \ 'f' : ['Format', 'format code']          ,
      \ 'l' : 'run C/C++ in floaterm'            ,
      \ 'r' : 'run async file'    ,
      \ 'b' : 'build async file'  ,
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : [''     , 'definition']      ,
        \ 't' : ['' , 'type-definition'] ,
        \ 'i' : ['' , 'implementation']  ,
        \ 'p' : [':cp' , 'go to previous problem']  ,
        \ 'n' : [':cn' , 'go to next problem']  ,
        \ },
      \ }
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5' , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5' , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ 'w' : 'save current buffer'                    ,
      \ 'o' : [':only'      , 'close other windows']   ,
      \ }

let g:which_key_map['s'] = [':write',   'save current buffer']
