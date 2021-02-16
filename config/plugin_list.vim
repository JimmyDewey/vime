" 语法检查
" Plug 'w0rp/ale'

" 代码补全插件
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" 检索
" Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }
" Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
" Plug 'junegunn/fzf.vim' | Plug 'antoinemadec/coc-fzf',  {'branch': 'release'}

" 注释插件
Plug 'scrooloose/nerdcommenter'
" 生成注释文档
Plug 'kkoomen/vim-doge', {'do': {-> doge#install()}}
" 主题theme类插件
Plug 'ajmwagar/vim-deus'
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/forest-night'
Plug 'srcery-colors/srcery-vim'
Plug 'hardcoreplayers/oceanic-material'
Plug 'chuling/ci_dark'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'mhartington/oceanic-next'
Plug '986299679/space-vim-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'w0ng/vim-hybrid'
Plug 'NLKNguyen/papercolor-theme'
Plug 'flrnd/candid.vim'
Plug 'jaredgorski/spacecamp'
Plug 'bluz71/vim-moonfly-colors'
Plug 'cormacrelf/vim-colors-github'
Plug 'arzg/vim-colors-xcode'
Plug 'sainnhe/sonokai'
Plug 'sonph/onehalf'
Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/edge'
Plug 'reedes/vim-colors-pencil'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
" 顶栏和底栏
" Plug 'rbong/vim-crystalline'
Plug 'itchyny/lightline.vim'
" 彩虹括号
Plug 'luochen1990/rainbow'
" 函数列表
Plug 'liuchengxu/vista.vim', {'on': ['Vista!!', 'Vista']}
" 自动补全括号
Plug 'jiangmiao/auto-pairs'
" 重复上次的动作
Plug 'tpope/vim-repeat'
" 显示清除尾部空格
Plug 'ntpeters/vim-better-whitespace'
" 代码段
Plug 'honza/vim-snippets'
" 快速选择窗口
Plug 't9md/vim-choosewin'
" 快速移动
Plug 'easymotion/vim-easymotion', {'on':
   \ [
   \ '<Plug>(easymotion-bd-f)', '<Plug>(easymotion-overwin-f)',
   \ '<Plug>(easymotion-overwin-f2)', '<Plug>(easymotion-bd-jk)',
   \ '<Plug>(easymotion-overwin-line)', '<Plug>(easymotion-bd-w)',
   \ '<Plug>(easymotion-overwin-w)', '<Plug>(easymotion-s)',
   \ ]}
" 对齐
Plug 'junegunn/vim-easy-align', {'on': ['EasyAlign', '<Plug>(EasyAlign)']}
" 多光标
Plug 'mg979/vim-visual-multi'
" 悬浮终端
Plug 'voldikss/vim-floaterm', {'on': ['FloatermNew', 'FloatermToggle']}
" 功能很强的折叠插件, zc zo
Plug 'pseewald/vim-anyfold'
" 起始界面
Plug 'mhinz/vim-startify'
" 关闭buffer而不关闭窗口
Plug 'rbgrouleff/bclose.vim', {'on': 'Bclose'}
" 平滑滚动
Plug 'psliwka/vim-smoothie'
" vim中文文档
Plug 'yianwillis/vimcdoc'
" CPP语法高亮
Plug 'octol/vim-cpp-enhanced-highlight'
" 总是匹配tag
Plug 'valloric/MatchTagAlways', {'for': ['html', 'css', 'xml']}
" 显示颜色 例如: #654456
if has('nvim')
    Plug 'norcalli/nvim-colorizer.lua'
else
    Plug 'RRethy/vim-hexokinase',  { 'do': 'make hexokinase' }
endif
" 查看启动时间
Plug 'dstein64/vim-startuptime', {'on':'StartupTime'}

" coc插件列表，可根据需要进行删减
let g:coc_global_extensions = [
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yank',
    \ 'coc-sh',
    \ 'coc-yaml',
    \ 'coc-cmake',
    \ 'coc-snippets',
    \ 'coc-clangd',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-word',
    \ 'coc-python',
    \ 'coc-explorer',
    \ 'coc-ci',
    \ 'coc-prettier',
    \ 'coc-actions',
    \ 'coc-tsserver',
    \ 'coc-emmet',
    \ 'coc-html',
    \ 'coc-python',
    \ 'coc-css',
    \ 'coc-highlight',
    \ ]

    " \ 'coc-git',
    " \ 'coc-marketplace',
    " \ 'coc-calc',
    " \ 'coc-tabnine',
    " \ 'coc-fzf-preview',
    " \ 'coc-bookmark',
    " \ 'coc-rainbow-fart',

" 运行C/C++
Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop'] }
Plug 'skywind3000/asynctasks.vim', {'on': ['AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit'] }

Plug 'liuchengxu/vim-which-key'

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
" [开头的快捷键
Plug 'tpope/vim-unimpaired'

" 撤销树
Plug 'simnalamburt/vim-mundo'

" javascript语法高亮
Plug 'pangloss/vim-javascript'
