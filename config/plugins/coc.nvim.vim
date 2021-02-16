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

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" shift tab 选择上一个补全
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> [h <Plug>(coc-diagnostic-next)
" nmap <silent> <C-r>=CocActionAsync('showSignatureHelp')<CR>
"   转到定义
nmap <silent> gd <Plug>(coc-definition)
"   转到类型定义
nmap <silent> gy <plug>(coc-type-definition)
"   转到实现
nmap <silent> gi <plug>(coc-implementation)
"   转到引用
nmap <silent> gr <plug>(coc-references)
"   构refactor,  要lsp  持
nmap <silent> <space>rf <Plug>(coc-refactor)
"   修复代码
nmap <silent> <space>lf  <Plug>(coc-fix-current)
"   量重命名
nmap <silent> <space>rn <Plug>(coc-rename)
.
"   用K  浮显示定义
nnoremap <silent> K :call <SID>show_documentation()<CR>
.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" 函数参数的文档
nnoremap <silent> <space>k :call CocActionAsync('showSignatureHelp')<CR>
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

" 显示光标下符号的文档
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>lx  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

nnoremap <silent> <space>lf :<C-u> Format<cr>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>la  :<C-u>CocList diagnostics<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>lo  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>ls  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>lj  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>lk  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>lp  :<C-u>CocListResume<CR>

"""""""""""""""""""""""
" coc-plug config
" 下面是coc插件的配置
"""""""""""""""""""""""

function! s:lc_coc_highlight() abort
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
endfunction

function! s:lc_coc_yank() abort
    call coc#config('yank.highlight.duration', 200)
    call coc#config('yank.enableCompletion', v:false)

    if !common#functions#HasPlug('vim-clap') && !common#functions#HasPlug('fzf')
        nnoremap <silent> <M-y>  :<C-u>CocList yank<cr>
    endif
    nnoremap <silent> <space>y  :<C-u>CocList yank<cr>
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
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]',
        \   },
        \   'buffer': {
              \     'sources': [{'name': 'buffer', 'expand': v:true}]
        \   },
    \ }

    " nmap <leader>e :CocCommand explorer<CR>

    " Use preset argument to open it
    nmap <space>ed :CocCommand explorer --preset .vim<CR>
    nmap <space>ef :CocCommand explorer --preset floating<CR>
    nmap <space>ec :CocCommand explorer --preset cocConfig<CR>
    nmap <space>es :CocCommand explorer --preset simplify<CR>
    nmap <space>ee :CocCommand explorer --preset simplify<CR>

    " List all presets
    nmap <space>el :CocList explPresets

    augroup vime_coc_explorer_group
        autocmd!
        " autocmd WinEnter * if &filetype == 'coc-explorer' && winnr('$') == 1 | q | endif
        autocmd TabLeave * if &filetype == 'coc-explorer' | wincmd w | endif
    augroup END

    " config
    call coc#config("explorer.icon.enableNerdfont", v:true)
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
            \ 'coc-todolist': function('<SID>lc_coc_todolist'),
            \ 'coc-clangd': function('<SID>lc_coc_clangd'),
            \ 'coc-xml': function('<SID>lc_coc_xml'),
            \ 'coc-prettier': function('<SID>lc_coc_prettier'),
            \ 'coc-git': function('<SID>lc_coc_git'),
            \ 'coc-snippets': function('<SID>lc_coc_snippets'),
            \ 'coc-python': function('<SID>lc_coc_python'),
            \ 'coc-rainbow-fart': function('<SID>lc_coc_rainbow_fart'),
            \ 'coc-explorer': function('<SID>lc_coc_explorer'),
            \ 'coc-vimlsp': function('<SID>lc_coc_vimlsp'),
            \ }

" TODO 更改调用方式
" 调用插件的配置函数
for extension in g:coc_global_extensions
    call get(s:coc_config_functions, extension, function('<SID>tmp'))()
endfor
