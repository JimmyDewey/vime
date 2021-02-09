" coc插件安装目录
let g:coc_data_home = g:cache_root_path . 'coc/'
" coc-settings.json所在目录
let g:coc_config_home = g:other_config_root_path

" 卸载不在列表中的插件
function! s:uninstall_unused_coc_extensions() abort
    for e in keys(json_decode(join(readfile(expand(g:coc_data_home . '/extensions/package.json')), "\n"))['dependencies'])
        if index(g:coc_global_extensions, e) < 0
            execute 'CocUninstall ' . e
        endif
    endfor
endfunction
autocmd User CocNvimInit call s:uninstall_unused_coc_extensions()

" 检查当前光标前面是不是空白字符
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab触发补全或者选择下一个补全
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<c-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

" shift tab 选择上一个补全
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ "\<C-h>"

" alt j选择下一个补全
inoremap <silent><expr> <m-j>
    \ pumvisible() ? "\<C-n>" : "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>"
    " \ pumvisible() ? "\<C-n>" : return

" " alt k选择上一个补全
inoremap <silent><expr> <m-k>
    \ pumvisible() ? "\<C-p>" : "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>"
    " \ pumvisible() ? "\<C-p>" : return

" down 选择下一个补全
inoremap <silent><expr> <down>
    \ pumvisible() ? "\<C-n>" : "\<down>"

" up 选择上一个补全
inoremap <silent><expr> <up>
    \ pumvisible() ? "\<C-p>" : "\<up>"

" alt j k 用于补全块的跳转，优先补全块跳转
if common#functions#HasCocPlug('coc-snippets')
    let g:coc_snippet_next = '<m-j>'
    let g:coc_snippet_prev = '<m-k>'
endif

" 回车选中或者扩展选中的补全内容
if exists('*complete_info')
    " 如果您的(Neo)Vim版本支持，则使用`complete_info`
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" diagnostic 跳转
nmap <silent> <M-j> <Plug>(coc-diagnostic-next)
nmap <silent> <M-k> <Plug>(coc-diagnostic-prev)

" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
" 跳转到类型定义
nmap <silent> gy <plug>(coc-type-definition)
" 跳转到实现
nmap <silent> gi <plug>(coc-implementation)
" 跳转到引用
nmap <silent> gr <plug>(coc-references)
" 重构refactor,需要lsp支持
nmap <silent> <space>rf <Plug>(coc-refactor)
" 修复代码
nmap <silent> <space>f  <Plug>(coc-fix-current)
" 变量重命名
nmap <silent> <space>rn <Plug>(coc-rename)

" 使用K悬浮显示定义
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" 函数文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 函数参数的文档
nnoremap <silent> <space>k :call CocActionAsync('showSignatureHelp')<CR>
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

" 格式化代码
if !common#functions#HasPlug('neoformat')
    command! -nargs=0 Format :call CocAction('format')
endif

" 文档块支持，比如删除条件，函数等
" 功能不如treesitter，如果不存在treesitter才使用coc
if !common#functions#HasPlug('nvim-treesitter')
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
endif

"""""""""""""""""""""""
" coc-plug config
" 下面是coc插件的配置
"""""""""""""""""""""""

function! s:lc_coc_highlight() abort
    " 取消csv的高亮
    call coc#config("highlight.disableLanguages", ["csv"])
    " 高亮当前光标下的所有单词
    au CursorHold * silent call CocActionAsync('highlight')
endfunction

function! s:lc_coc_lists() abort
    " session
    call coc#config('session.directory', g:session_dir)
    if common#functions#HasPlug('dashboard-nvim', 'vim-startify')
        call coc#config('session.saveOnVimLeave', v:false)
    else
        call coc#config('session.saveOnVimLeave', v:true)
    endif

    call coc#config('list.maxHeight', 10)
    call coc#config('list.maxPreviewHeight', 8)
    call coc#config('list.autoResize', v:false)
    call coc#config('list.source.grep.command', 'rg')
    call coc#config('list.source.grep.defaultArgs', [
                \ '--column',
                \ '--line-number',
                \ '--no-heading',
                \ '--color=always',
                \ '--smart-case'
            \ ])
    call coc#config('list.source.lines.defaultArgs', ['-e'])
    call coc#config('list.source.words.defaultArgs', ['-e'])
    call coc#config('list.source.files.command', 'rg')
    call coc#config('list.source.files.args', ['--files'])
    call coc#config('list.source.files.excludePatterns', ['.git'])

    " 有这三个插件就用这三个插件
    " 那么快捷键不调用coc-lists
    if common#functions#HasPlug('fzf.vim')
        \ || common#functions#HasPlug('LeaderF')
        \ || common#functions#HasPlug('vim-clap')
        \ || common#functions#HasPlug('fzf-preview.vim')
        \ || common#functions#HasCocPlug('coc-fzf-preview')
        return
    endif

    nnoremap <silent> <M-f> :call <SID>cocListFilesWithWiki("")<CR>
    nnoremap <silent> <M-F> :call <SID>cocListFilesWithWiki($HOME)<CR>
    nnoremap <silent> <M-b> :CocList buffers<CR>
    nnoremap <silent> <M-c> :CocList vimcommands<CR>
    " tags, 需要先generate tags
    nnoremap <silent> <M-t> :CocList tags<cr>
    nnoremap <silent> <M-s> :CocList --auto-preview --interactive grep<cr>
    nnoremap <silent> ? :CocList --auto-preview --interactive lines<cr>
    nnoremap <silent> <M-r> :CocList mru -A<CR>
    nnoremap <silent> <M-m> :CocList marks<CR>
    nnoremap <silent> <M-M> :CocList maps<CR>
    nnoremap <silent> <M-w> :CocList windows<CR>
    nnoremap <silent> <M-y> :CocList yank<CR>
    nnoremap <silent> <F8> :CocList locationlist<CR>
    nnoremap <silent> <F9> :CocList quickfix<CR>
endfunction

function! s:lc_coc_yank() abort
    call coc#config('yank.highlight.duration', 200)
    call coc#config('yank.enableCompletion', v:false)

    if !common#functions#HasPlug('vim-clap') && !common#functions#HasPlug('fzf')
        nnoremap <silent> <M-y>  :<C-u>CocList yank<cr>
    endif
    nnoremap <silent> <space>y  :<C-u>CocList yank<cr>
endfunction

function! s:lc_coc_translator() abort
    " nmap  <leader>e <Plug>(coc-translator-e)
    nmap  <leader>d <Plug>(coc-translator-p)
endfunction

function! s:lc_coc_bookmark() abort
    if common#functions#HasPlug('vim-bookmarks')
        return
    endif

    call coc#config("bookmark.sign", "♥")
    nmap <silent> ma <Plug>(coc-bookmark-annotate)
    nmap <silent> mm <Plug>(coc-bookmark-toggle)
    nmap <silent> mj <Plug>(coc-bookmark-next)
    nmap <silent> mk <Plug>(coc-bookmark-prev)
    nmap <silent> mc :CocCommand bookmark.clearForCurrentFile<cr>
    nmap <silent> ml :CocList bookmark<cr>
endfunction

function! s:lc_coc_todolist() abort
    nmap <silent> <space>tl :<C-u>CocList todolist<cr>
    nmap <silent> <space>ta :<C-u>CocCommand todolist.create<cr>
endfunction

function! s:lc_coc_clangd() abort
    call coc#config('clangd.semanticHighlighting', v:true)
endfunction

function! s:lc_coc_xml() abort
    call coc#config('xml.java.home', '/usr/lib/jvm/default/')
endfunction

function! s:lc_coc_prettier() abort
    call coc#config('prettier.tabWidth', 2)
endfunction

function! s:lc_coc_vimlsp() abort
    let g:markdown_fenced_languages = [
        \ 'vim',
        \ 'help'
    \ ]
endfunction

function! s:lc_coc_git() abort
    call coc#config('git.addGBlameToBufferVar', v:true)
    call coc#config('git.addGBlameToVirtualText', v:true)
    call coc#config('git.virtualTextPrefix', '  ➤  ')
    if common#functions#HasPlug("vim-gitgutter")
        call coc#config('git.addedSign.hlGroup', 'GitGutterAdd')
        call coc#config('git.changedSign.hlGroup', 'GitGutterChange')
        call coc#config('git.removedSign.hlGroup', 'GitGutterDelete')
        call coc#config('git.topRemovedSign.hlGroup', 'GitGutterDelete')
        call coc#config('git.changeRemovedSign.hlGroup', 'GitGutterChangeDelete')
    endif
    call coc#config('git.addedSign.text', '▎')
    call coc#config('git.changedSign.text', '▎')
    call coc#config('git.removedSign.text', '▎')
    call coc#config('git.topRemovedSign.text', '▔')
    call coc#config('git.changeRemovedSign.text', '▋')

    " 导航到修改块
    nmap <leader>gk <Plug>(coc-git-prevchunk)
    nmap <leader>gj <Plug>(coc-git-nextchunk)
    " 显示光标处的修改信息
    nnoremap <silent> <leader>gp <esc>:CocCommand git.chunkInfo<cr>
    " 撤销当前块的修改
    nnoremap <silent> <leader>gu <esc>:CocCommand git.chunkUndo<cr>
    nnoremap <silent> <leader>gh <esc>:CocCommand git.chunkStage<cr>
endfunction

function! s:lc_coc_snippets() abort
    call coc#config("snippets.ultisnips.enable", v:true)
    call coc#config("snippets.ultisnips.directories", [
                \ g:other_config_root_path . '/UltiSnips',
                \ g:other_config_root_path . '/gosnippets/UltiSnips',
            \ ])
    call coc#config("snippets.extends", {
                \ 'cpp': ['c', 'cpp'],
                \ 'typescript': ['javascript']
            \ })
endfunction

function! s:lc_coc_python() abort
    call coc#config("python.jediEnabled", v:true)
    call coc#config("python.linting.enabled", v:true)
    call coc#config("python.linting.pylintEnabled", v:true)
endfunction

function! s:lc_coc_ci() abort
    nmap <silent> w <Plug>(coc-ci-w)
    nmap <silent> b <Plug>(coc-ci-b)
endfunction

function! s:lc_coc_rainbow_fart() abort
    call coc#config("rainbow-fart.ffplay", "ffplay")
endfunction


function! s:lc_coc_explorer() abort
    let g:coc_explorer_global_presets = {
        \   '.vim': {
        \      'root-uri': g:vim_root_path,
        \   },
        \   'floating': {
        \      'position': 'floating',
        \      'floating-position': 'center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \      'file-child-template': '[git | 2] [selection | clip | 1]
                    \ [indent] [icon | 1] [diagnosticError & 1]
                    \ [filename omitCenter 1][modified][readonly]
                    \ [linkIcon & 1][link growRight 1] [timeCreated | 8] [size]'
        \   },
        \   'floatingTop': {
        \     'position': 'floating',
        \     'floating-position': 'center-top',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingLeftside': {
        \      'position': 'floating',
        \      'floating-position': 'left-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingRightside': {
        \      'position': 'floating',
        \      'floating-position': 'right-center',
        \      'floating-width': 100,
        \      'open-action-strategy': 'sourceWindow',
        \   },
        \   'simplify': {
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
        \   }
    \ }

    " Use preset argument to open it
    " nmap <space>rd :CocCommand explorer --preset .vim<CR>
    nmap <leader>e :CocCommand explorer<CR>
    " if !common#functions#HasPlug('ranger.vim')
    "    nmap <leader>f :CocCommand explorer --preset floating<CR>
    " endif

    augroup vime_coc_explorer_group
        autocmd!
        " autocmd WinEnter * if &filetype == 'coc-explorer' && winnr('$') == 1 | q | endif
        autocmd TabLeave * if &filetype == 'coc-explorer' | wincmd w | endif
    augroup END

    " config
    call coc#config("explorer.icon.enableNerdfont", v:true)
    call coc#config("explorer.bookmark.child.template", "[selection | 1] [filename] [position] - [annotation]")
    call coc#config("explorer.file.column.icon.modified", "•")
    call coc#config("explorer.file.column.icon.deleted", "✖")
    call coc#config("explorer.file.column.icon.untracked", "ᵁ")
    call coc#config("explorer.file.column.icon.renamed", "R")
    call coc#config("explorer.file.column.icon.unmerged", "≠")
    call coc#config("explorer.file.column.icon.ignored", "ⁱ")
    call coc#config("explorer.keyMappings.global", {
      \ 'k': 'nodePrev',
      \ 'j': 'nodeNext',
      \ 'h': 'collapse',
      \ 'l': ['expandable?', 'expand', 'open'],
      \ 'L': 'expand:recursive',
      \ 'H': 'collapse:recursive',
      \ 'K': 'expandablePrev',
      \ 'J': 'expandableNext',
      \ '<cr>': ['expandable?', 'cd', 'open'],
      \ '<bs>': 'gotoParent',
      \ 'r': 'refresh',
      \ 'v': ['toggleSelection', 'normal:j'],
      \ 'V': ['toggleSelection', 'normal:k'],
      \ '*': 'toggleSelection',
      \ '<c-s>': 'open:split',
      \ '<c-v>': 'open:vsplit',
      \ 't': 'open:tab',
      \ 'dd': 'cutFile',
      \ 'Y': 'copyFile',
      \ 'D': 'delete',
      \ 'P': 'pasteFile',
      \ 'R': 'rename',
      \ 'N': 'addFile',
      \ 'yp': 'copyFilepath',
      \ 'yn': 'copyFilename',
      \ 'gp': 'preview:labeling',
      \ '<M-x>': 'systemExecute',
      \ 'f': 'search',
      \ 'F': 'searchRecursive',
      \ '<tab>': 'actionMenu',
      \ '?': 'help',
      \ 'q': 'quit',
      \ '<esc>': 'esc',
      \ 'gf': 'gotoSource:file',
      \ 'gb': 'gotoSource:buffer',
      \ '[[': 'sourcePrev',
      \ ']]': 'sourceNext',
      \ '[d': 'diagnosticPrev',
      \ ']d': 'diagnosticNext',
      \ '[c': 'gitPrev',
      \ ']c': 'gitNext',
      \ '<<': 'gitStage',
      \ '>>': 'gitUnstage'
    \ })
endfunction

function! s:tmp() abort
endfunction

" 遍历coc插件列表，载入插件配置
let s:coc_config_functions = {
            \ 'coc-highlight': function('<SID>lc_coc_highlight'),
            \ 'coc-lists': function('<SID>lc_coc_lists'),
            \ 'coc-yank': function('<SID>lc_coc_yank'),
            \ 'coc-translator': function('<SID>lc_coc_translator'),
            \ 'coc-todolist': function('<SID>lc_coc_todolist'),
            \ 'coc-clangd': function('<SID>lc_coc_clangd'),
            \ 'coc-xml': function('<SID>lc_coc_xml'),
            \ 'coc-prettier': function('<SID>lc_coc_prettier'),
            \ 'coc-git': function('<SID>lc_coc_git'),
            \ 'coc-snippets': function('<SID>lc_coc_snippets'),
            \ 'coc-python': function('<SID>lc_coc_python'),
            \ 'coc-rainbow-fart': function('<SID>lc_coc_rainbow_fart'),
            \ 'coc-explorer': function('<SID>lc_coc_explorer'),
            \ 'coc-ci': function('<SID>lc_coc_ci'),
            \ 'coc-vimlsp': function('<SID>lc_coc_vimlsp'),
            \ }

" TODO 更改调用方式
" 调用插件的配置函数
for extension in g:coc_global_extensions
    call get(s:coc_config_functions, extension, function('<SID>tmp'))()
endfor
