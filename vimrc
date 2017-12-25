execute pathogen#infect()
syntax on
filetype plugin indent on
Helptags
set encoding=utf-8
set clipboard=unnamedplus

" hotkeys and options {{{
augroup exit_group
    command! Q q
    command! W w
    command! WQ wq
    command! Wq wq    
augroup END
" move line down
nnoremap - :m .+1<CR>==
" move line up
nnoremap _ :m .-2<CR>==
" convert the current word to uppercase
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU
" remap escape to jk and kj
inoremap jk <Esc>
" moving inside lines
nnoremap j gj
nnoremap k gk
" set leader
let maplocalleader=","
let mapleader=";"
" folding
set foldmethod=indent
set foldlevel=99
" no backup
set nobackup
set nowritebackup
set noswapfile
" search settings
set hlsearch incsearch
nnoremap <CR> :noh<CR><CR>
" backspace
set backspace=indent,eol,start
" complete with TAB
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible()? "\<c-p>":"\<c-d>"
" notes with ctrl+b
nnoremap <C-b> :vsplit note:org<CR>
"}}}
" view {{{
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
let &colorcolumn=81
set number
set relativenumber
" preview window
set previewheight=5
au BufEnter ?* call PreviewHeightWorkAround()
function! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc
set splitbelow
" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
" completion with ctrl+space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" }}}
" R settings - Nvim-R {{{
" Nvim-R
let R_in_buffer = 0
let R_tmux_split = 1
let R_args_in_stline = 1
let R_close_term = 1
augroup filetype_R
    autocmd!
    autocmd BufRead,BufNewFile *.[Rr] nmap <Space> <LocalLeader>l<Enter>
    autocmd BufRead,BufNewFile *.[Rr] nmap <F2> <LocalLeader>rf
    autocmd BufRead,BufNewFile *.[Rr] nmap <LocalLeader>h <LocalLeader>rh
    autocmd BufRead,BufNewFile *.[Rr] nmap <LocalLeader>v <LocalLeader>rv
    autocmd BufRead,BufNewFile *.[Rr] nmap <F5> <LocalLeader>aa
    autocmd BufRead,BufNewFile *.Rnw nmap <Space> <LocalLeader>l<Enter>
    autocmd BufRead,BufNewFile *.Rnw nmap <F2> <LocalLeader>kp
    autocmd BufRead,BufNewFile *.Rnw nmap <F3> <LocalLeader>op
    autocmd BufRead,BufNewFile *.Rnw nmap <LocalLeader>rf <Plug>RStart
    " abbreviations
    function! Eatchar(pat)
        let c = nr2char(getchar(0))
        return (c =~ a:pat) ? '' : c
    endfunc
    autocmd FileType r iabbrev <silent> if if () {<CR><TAB><CR>}<Esc>kkwa<C-R>=Eatchar('\s')<CR>
    autocmd FileType r iabbrev <silent> for for () {<CR><TAB><CR>}<Esc>kk$ba<C-R>=Eatchar('\s')<CR>
    autocmd FileType r iabbrev <silent> function function() {<CR><TAB><CR>}<Esc>kk$hhi<C-R>=Eatchar('\s')<CR>
    " folds
    function! RFolds()
        let thisline = getline(v:lnum)
        if match(thisline, "# ----") >= 0
            return ">1"
        elseif match(thisline, "## ---") >= 0
            return ">2"
        else 
            return "="
        endif
    endfunc
    autocmd FileType r setlocal foldmethod=expr
    autocmd FileType r setlocal foldexpr=RFolds()
    autocmd FileType r setlocal softtabstop=0 expandtab shiftwidth=2 smarttab
augroup END
" }}}
" latex settings - vim-latex {{{
let g:Tex_ViewRule_pdf = 'zathura'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_SmartKeyDot=0
augroup filetype_tex
    autocmd!
    autocmd FileType tex NeoCompleteLock    
    autocmd FileType tex setlocal foldlevel=1
    autocmd BufRead,BufNewFile *.tex map <F2> <Esc>:w<Enter><leader>ll<Return>
    autocmd BufRead,BufNewFile *.tex map <F4> <Esc><leader>ll<Return>:<C-U>exec '!bibtex '.Tex_GetMainFileName(':p:t:r')<CR><leader>ll<Return>
    autocmd BufRead,BufNewFile *.tex map <F3> <leader>lv
augroup END
" }}}
" python settings - python-mode {{{
augroup filetype_python
    autocmd!
    "map <F5> <Esc><leader>r
    autocmd BufRead,BufNewFile *.py nmap <F5> :exec 'w !python3'<cr>
    " screen (for python)
    autocmd BufRead,BufNewFile *.py nmap <F2> :ScreenShell python3<Return>
    autocmd BufRead,BufNewFile *.py nmap <Space> V:ScreenSend<CR>j
augroup END
" }}}
" vimscript settings ------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}
" various plugins {{{
" vim-airline (powerline) 
let g:airline_powerline_fonts = 1
set laststatus=2  " always show status line
let g:airline_theme='laederon'
let g:airline#extensions#tabline#enabled = 1

" gitgutter
set updatetime=250
let g:gitgutter_max_signs = 500  " default value

" NERDtree 
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']  " ignore .pyc files
augroup nertree
    autocmd!
    " close NERDtree if it is the only pane opened
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" rainbow (parentheses)
let g:rainbow_active = 1 

" csv
let g:csv_autocmd_arrange = 1
autocmd BufRead,BufNewFile *.csv nnoremap <LocalLeader>a <Esc>ggVG:ArrangeColumn<CR>

" neocomplete.vim
let g:neocomplete#enable_at_startup = 1 
let g:neocomplete#sources#omni#functions = {'r': 'CompleteR'}
let g:neocomplete#sources#omni#input_patterns = {'r': '[[:alnum:].\\]\+'}
" start_length doesn't work: change min_pattern_length from 0 to 3 in all files 
" in bundle/neocomplete
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#sources#buffer#cache_limit_size = 500000
let g:neocomplete#enable_fuzzy_completion = 0
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#manual_completion_start_length = 4
inoremap <expr><Tab>  neocomplete#start_manual_complete()
let g:neocomplete#auto_complete_delay = 400
autocmd! FileType python setlocal omnifunc=pythoncomplete#Complete
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" undotree
noremap <c-z> :UndotreeToggle<CR>

" dbext.vim 
let file_path = $HOME . "/pass/pass.txt"
let g:dbext_default_user = readfile(file_path)[0]
let g:dbext_default_passwd = readfile(file_path)[1]
let g:dbext_default_host = readfile(file_path)[2]
let g:dbext_default_dbname = readfile(file_path)[3]
let g:dbext_default_type = readfile(file_path)[4]

autocmd BufRead,BufNewFile *.sql nmap <space> <leader>sel
autocmd BufRead,BufNewFile *.sql vmap <space> <leader>se

" }}}

