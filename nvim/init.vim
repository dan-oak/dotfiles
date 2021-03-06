" init.vim - make it easier to make it easier to edit text {{{
" edit and apply init.vim quickly from whenever you are

" [e]dit [v]imrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" [t]ab-edit [v]imrc
nnoremap <leader>tv :tabnew $MYVIMRC<cr>
" [s]ource [v]imrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"}}}

" plugins {{{
" list of plugins to install
" https://github.com/junegunn/vim-plug
" cheatsheet: PlugStatus PlugUpdate
call plug#begin('~/.config/nvim/plugged/')
    " CamelCase motion through words
    " https://github.com/bkad/CamelCaseMotion
    Plug 'bkad/CamelCaseMotion'

    " word-flipping: change the order of 2 delimited pieces of text
    " https://github.com/mmahnic/vim-flipwords
    Plug 'mmahnic/vim-flipwords'

    " AsciiDoc syntax
    Plug 'asciidoc/vim-asciidoc', { 'for': 'asciidoc' }

    " increment/decrement of values (bool, int, numeric, hex)
    " https://github.com/vim-scripts/nextval
    Plug 'vim-scripts/nextval'

    " section folding for markdown syntax
    Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }

    " Groovy syntax
    Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }

    " filesystem tree explorer
    Plug 'scrooloose/nerdtree'
call plug#end()
call camelcasemotion#CreateMotionMappings('<leader>')
" }}}

" basic settings {{{

" modelines - lines of special commented code to set options for one or more files
" disable modelines
set modelines=0

" syntax highlighting
syntax on

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" non-printable characters
set listchars=eol:¶,space:·,tab:›·,extends:⟫,precedes:⟪,

set mouse=a

set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2

" cursor needs freedom!
set virtualedit=all

" line numbers
set relativenumber
set number

" undo/rescue files
set undofile
set dir=~/.nvim-tmp

" }}}

" basic mappings {{{

" save file
nnoremap <f2> <esc>:write<cr>

" save & close
nnoremap <f4> <esc>:write<cr>:quit<cr>

" save file using sudo
command! W write !sudo tee > /dev/null %

" clear trailing spaces from end of each line
nnoremap <leader>notrail :%s/\s\+$//e<cr>

" insert newlines ('vertical' indent)
nnoremap >< O<esc>j
nnoremap <> o<esc>k

" scrolling {{{
" help pages: scroll-up, scroll-down, scroll-horizontal

" single step
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>
nnoremap <c-h> zh
nnoremap <c-l> zl

" half screenwidth
" FIXME unfortunately, ctrl-shift works like simgle ctrl, so use alt
nnoremap <c-a-j> <c-u>
nnoremap <c-a-k> <c-d>
nnoremap <c-a-h> zH
nnoremap <c-a-l> zL

" }}}

" }}}

" status line {{{

set stl=%f         " Path to the file
set stl+=%=        " Switch to the right side
set stl+=%B
set stl+=\
set stl+=%l        " Current line
set stl+=-
set stl+=%c        " Current column
set stl+=\|        " Separator
set stl+=%L        " Total lines

" }}}

" display lines navigation by arrows {{{

nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" do not let myself navigate in insert mode {{{

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" }}}

" }}}

" searching {{{

" searching by regular expressions {{{

nnoremap / /\v
vnoremap / /\v

" }}}

set ignorecase
set smartcase
set gdefault
set showmatch

" search highligthing {{{

" first match when typing pattern
set incsearch

" all matches if search is set
set hlsearch

" }}}

" clear search {{{

" highlighting
nnoremap <leader><space> :noh<cr>
nnoremap <esc> :noh<cr>

" the register
nnoremap <leader><space><space> :let @/=''<cr>

" }}}

" copy search matches {{{

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" }}}

" }}}

" line breaking {{{

set wrap

" }}}

" move {{{
    " move around things {{{
        " words
        nnoremap H b
        nnoremap L e
        " jump history
        nnoremap <A-Left>  <C-o>
        nnoremap <A-Right> <C-i>
    " }}}
    " move things around {{{
        " lines
        nnoremap <A-Down> :m .+1<CR>
        nnoremap <A-Up>   :m .-2<CR>
        vnoremap <A-Down> :m '>+1<CR>gv
        vnoremap <A-Up>   :m '<-2<CR>gv
    " }}}
" }}}

" signature abbreviations {{{

iabbrev @Sig@ Dan Oak <danylo.dubinin@gmail.com>
iabbrev @sig@ Dan Oak <danylo.dubinin@gmail.com>
iabbrev @Sigf@ Danylo Dubinin <danylo.dubinin@gmail.com>
iabbrev @Sigu@ Данило Дубінін <danylo.dubinin@gmail.com>

" }}}

" surround word {{{

nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>lel

" }}}

" exit insert mode {{{

inoremap jk <esc>

" }}}

" filetype-specific settings {{{

" limit line length {{{

augroup line_length
    autocmd!
    autocmd FileType markdown,asciidoc,c,python,prolog
        \ setlocal textwidth=79 colorcolumn=+2
augroup END

" }}}

" html {{{

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
    autocmd FileType html :iabbrev <buffer>Tp <p></p><esc>F<i
    autocmd FileType html setlocal nowrap
augroup END

" }}}

" markdown {{{

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal colorcolumn=81 textwidth=79
augroup END

" }}}

" asciidoc {{{

augroup filetype_markdown
    autocmd!
    autocmd FileType asciidoc setlocal colorcolumn=81 textwidth=79
    autocmd FileType asciidoc setlocal syntax=asciidoc
augroup END

" }}}

" gitcommit {{{

augroup filetype_gitcommit
    autocmd!
    autocmd Filetype gitcommit setlocal textwidth=72
augroup END

" }}}

" vimscript {{{

augroup filetype_vim
    autocmd!

    " folding {{{
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevelstart=0
    " }}}

    autocmd FileType vim setlocal nolist

    " see basic mappings
    autocmd Filetype vim autocmd BufWritePre <buffer> :%s/\s\+$//e

augroup END

" }}}

" python {{{

augroup filetype_python
    autocmd!

    noremap <leader>printfix g/print/normal! el(A)

augroup END

" }}}

" }}}

" multiple windows {{{
" windows... windows are everywhere...

set winminheight=0

" switching between tabs
nnoremap <tab> :tabnext<cr>
nnoremap <S-tab> :tabprevious<cr>

" switching between windows
nnoremap <A-tab> <C-w>w
" <S-A-tab> doesnt work :< it uses previous <S-tab> mapping instead!

" }}}

" sessions {{{

set sessionoptions+=options

" }}}

" folding {{{
set foldtext=MyFoldText()
function! MyFoldText()
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|{{'.'{\d\=', '', 'g')
    return sub
endfunction
highlight Folded guibg=darkgrey guifg=white
" }}}

" logging vim messages {{{
    if !empty(glob("~/log/nvim/messages.txt"))
        set verbosefile=~/log/nvim/messages.txt
        set verbose=12
    else
        set verbose=0
    endif
" }}}

