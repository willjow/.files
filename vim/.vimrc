" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
"
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!
filetype plugin on
syntax on
set t_Co=256
colorscheme darkblue
set number
set ignorecase
set smartcase
set wrap lbr
set report=0
set display+=truncate
set nohlsearch " Turns out search highlighting is really annoying and distracting
let maplocalleader="\<Tab>"

" Status Line
" TODO make this cool
set laststatus=1

" Style Stuff
filetype plugin indent on
set tabstop=4     " tabs are at proper location
set softtabstop=4 " deleting tabs in insert treats them as tabs, not spaces
set expandtab     " don't use actual tab character (ctrl-v)
set shiftwidth=4  " indenting is 4 spaces
set autoindent    " turns it on

" set tabs to 2 for C files
autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2

" vim-plug stuff
call plug#begin('~/.vim/plugged')
Plug 'jalvesaq/Nvim-R'
Plug 'lervag/vimtex'
call plug#end()

" vimtex
autocmd FileType tex setlocal spell spelllang=en_us
let g:vimtex_view_use_temp_files=1
let g:vimtex_view_method='zathura'

" Nvim-R
let R_in_buffer=0
let R_term='urxvt'
let R_openhtml=1
let R_openpdf=1

" NERDTree is not for me
let g:netrw_liststyle=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_fastbrowse=2
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"
set noea

" Keybind to open the directory listing
" (set selected directory to be root of tree with "gn")
" (open selected file in previous split with "P")

" nnoremap <C-n> :15Lexplore<CR>
" this makes things less versatile because for some reason
" the browse split behavior changes globally, even after 
" toggling off the Lexplore window

" the following bind is the 'old,' manual approach,
" which resolves the issue mentioned above

" (older bind that automatically switches to tree view)
" nnoremap <C-n> :vs. <bar> vertical res 25 <bar> call feedkeys('iii')<CR>

nnoremap <C-n> :vs. <bar> vertical res 25 <CR>

" Vim Directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Enable scrolling
set mouse=nvc
set ttymouse=xterm2

"""""""""""
" Keymaps "
"         "
"""""""""""
cabbrev w!! w !sudo tee > /dev/null %:p
map <Enter> o<esc>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Move By Displayed Line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> ^ g^
noremap <silent> $ g$

onoremap <silent> k k
onoremap <silent> j j
onoremap <silent> ^ ^
onoremap <silent> $ $

" Move In Insert Mode
inoremap <C-l>  <Esc><Right>a
inoremap <C-h>  <Esc><Left>a

" Tabs
" Switch to last-active tab
if !exists('g:Lasttab')
    let g:Lasttab = 1
    let g:Lasttab_backup = 1
endif
autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()
autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup
nnoremap T :exe "tabn " . g:Lasttab<CR>

nnoremap <C-t> :tabnew<CR>
nnoremap gf :tablast<CR>
nnoremap gF :tabfirst<CR> 
nnoremap gl :tabm +<CR>
nnoremap gh :tabm -<CR>
nnoremap gj :tabm  <CR>
nnoremap gk :tabm 0<CR>
nnoremap J  :tabn<CR>
nnoremap K  :tabp<CR>

" Auto save/load folds
" This had a bunch of weird buffer side effects, so I commented it out
"
" set viewoptions-=options
" au BufWritePost,BufLeave,WinLeave ?* mkview
" au BufReadPre ?* silent loadview

" Auto Complete Closing Characters

" reduce the timeout cause I don't like waiting a second each time
set timeoutlen=250 
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     "
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     '
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
