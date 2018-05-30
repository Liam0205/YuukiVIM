" not compatible with Vi
set nocompatible

" test current Operation System
if (has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif
" encoding settings
if (g:iswindows==1)
    set encoding=chinese
    set fileencoding=chinese
else
    set encoding=utf-8
    set fileencoding=utf-8
endif
" enable the use of mouse
if (g:iswindows==1)
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif

" enable backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
" do not wrap automatically
set nowrap
" promote a confirm when fail to save
set confirm
" show line number
set number
" disable error noticing bells
set vb t_vb=
" status bar
set laststatus=2
set statusline=[%F]%y%r%m%*%{ALEGetStatusLine()}%=[Line:%l/%L,Column:%c][%p%%]
set ruler
" highlight current line
if version >= 700
    set cursorline
    if has("gui_running")
        hi cursorline guibg=#333333
        hi cursorColumn guibg=#333333
    endif
endif

" indent and tab
set autoindent              " automatically make an indent based on the indentation of the last line
set cindent                 " determine the length of indentation based on the syntax of Clang
set smartindent             " redefine the length of indentation based on current file
set expandtab               " expand tab into spaces
set softtabstop=4           " the width of a soft tab
set tabstop=4               " the width of a hard tab
set shiftwidth=4            " the width of >> and << shifted
set smarttab                " redefine the width of a soft tab based on current file
retab                       " replace all tabs into spaces on EnterBuffer

" brace and bracket matching
set showmatch
set matchtime=2
set matchpairs=(:),[:],{:},<:>

" searching
set hlsearch                " highlight on searching
set incsearch               " highlight on searching realtime

" syntax highlighting
syntax on
" filetype detect
filetype on
filetype plugin on
filetype indent on

" set fold
set foldenable              " enable fold
set foldmethod=syntax       " fold based on syntax
set foldcolumn=0            " the column of fold
setlocal foldlevel=1        " the depth level of fold
set foldlevelstart=10000    " do not fold by default
"set foldclose=all          " auto close fold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " swith fold by space

" set tab switch
:nn <Tab> :tabn<CR>
:nn <C-k> :tabp<CR>
:nn <C-j> :tabn<CR>

" 100 column markup
let &colorcolumn="100,".join(range(400,999),",")   

" backup
set backup
set writebackup
set backupdir=~/.tmp
if !isdirectory($HOME."/.tmp")
    if exists("*mkdir")
        silent! call mkdir($HOME."/.tmp", "", 0755)
    else
        silent! call system("mkdir ".$HOME."/.tmp")
    endif
endif

" set leader key
let mapleader=","
let g:mapleader=","

" auto commands
if has("autocmd")
    " automatically write file, when leave insert mode
    autocmd InsertLeave *.* write
    " removed spaces tailed at the end of lines on save
    autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e
    " change dir to the base of the calling of vim foobar
    " autocmd BufEnter * silent! cd -
    " autocmd BufEnter * lcd %:p:h
    " maintain the position of last modification
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exec "normal g'\"" |
        \ endif
endif

" ======================
"    plugin settings
" ======================
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
    " vim-gutentags, modern tags manager
    Plug 'ludovicchabant/vim-gutentags'
    " ale, Asynchronous Lint Engine
    Plug 'w0rp/ale'
" initialize plugin system
call plug#end()

" tags
set tags=./.tags;,.tags
" the pattern used by gutentags to determine the root of the project
let g:gutentags_project_root = ['BLADE_ROOT', '.root', '.svn', '.git', '.hg', '.project']
" the name of the tags file
let g:gutentags_ctags_tagfile = '.tags'
" save tags files into ~/.cache/tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if (!isdirectory(s:vim_tags))
   silent! call mkdir(s:vim_tags, 'p')
endif
" flags of ctags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" ale
let g:ale_sign_column_always         = 1
let g:ale_linters_explicit           = 1
let g:ale_completion_delay           = 500
let g:ale_echo_delay                 = 20
let g:ale_lint_delay                 = 500
let g:ale_sign_error                 = '>>'
let g:ale_sign_warning               = '--'
let g:ale_echo_msg_format            = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed       = 'normal'
let g:ale_lint_on_insert_leave       = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_statusline_format          = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_linters                    = { 'c++': ['g++'], 'c': ['gcc'] }
let g:ale_c_gcc_options              = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options            = '-Wall -O2 -std=c++11'
let g:ale_c_cppcheck_options         = ''
let g:ale_cpp_cppcheck_options       = ''
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>s :ALEToggle<CR>
nmap <Leader>d :ALEDetail<CR>















