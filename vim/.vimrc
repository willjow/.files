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
" Vim Directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set viewdir=~/.vim/view//

" Preliminary Settings
filetype plugin on
syntax enable

" vim-plug stuff
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'andymass/vim-matchup'
Plug 'jalvesaq/Nvim-R'
call plug#end()

" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnippets/']
let g:UltiSnipsListSnippets="<C-u>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
nnoremap <C-p> :call UltiSnips#RefreshSnippets()<CR>

" vimtex
" autocmd FileType tex setlocal spell spelllang=en_us
let g:vimtex_view_use_temp_files=1
let g:vimtex_view_method='zathura'
let g:vimtex_matchparen_enabled = 1
let g:matchup_override_vimtex = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {}

" tex-conceal
set conceallevel=2
let g:tex_conceal='abdmg'

" Nvim-R
let R_in_buffer=0
let R_term='urxvt'
let R_openhtml=1
let R_openpdf=1
let R_assign=0

" 'Basic' Settings
set number relativenumber
set ignorecase
set smartcase
set wrap lbr
set report=0
set display+=truncate
set scrolloff=12
set nohlsearch " Turns out search highlighting is really distracting
set cursorline
set nocursorcolumn
set noshowcmd
let maplocalleader="\<Tab>"

" Enable scrolling
set mouse=nvc
set ttymouse=xterm2

" VirtualEdit
set virtualedit=block

" Style Stuff
filetype indent on
set tabstop=4     " tabs are at proper location
set softtabstop=4 " deleting tabs in insert treats them as tabs, not spaces
set expandtab     " don't use actual tab character (ctrl-v)
set shiftwidth=4  " indenting is 4 spaces
set autoindent    " turns it on

" Auto-formatting
" python pattern: ^\s*[\[({]?(\d+|[\*\+\>\-])[:.]?[\])}]?\s+
set formatlistpat=^\\s*[\\[({]\\?\\(\\d\\+\\\|[\\*\\+\\>\\-]\\)[:.]\\?[\\])}]\\?\\s\\+
set textwidth=79
set formatoptions=croqnl1j
set nojoinspaces

" Toggle Text Autoformatting
function AutoFormatOn()
    :set formatoptions+=t
    :nnoremap <C-t> :call AutoFormatOff()<CR>
endfunction

function AutoFormatOff()
    :set formatoptions-=t
    :nnoremap <C-t> :call AutoFormatOn()<CR>
endfunction

nnoremap <C-t> :call AutoFormatOn()<CR>

" set tabs to 2 for certain files
autocmd FileType c,cpp,sh setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ColorScheme
set t_Co=256
set cc=
colorscheme darkblue

" Custom Highlights
" Xterm Colors table:
"   number  name        rgb
"   0       Black       (0, 0, 0)
"   9       Red         (255, 0, 0)
"   10      Lime        (0, 255, 0)
"   11      Yellow      (255, 255, 0)
"   15      White       (255, 255, 255)
"   16      Grey0       (0, 0, 0)
"   68      SteelBlue3  (95, 135, 215)
"   124     Red3        (175, 0, 0)
"   188     Grey84      (215, 215, 215)
"   238     Grey27      (68, 68, 68)
hi User1 ctermbg=68 ctermfg=16 cterm=None
hi User2 ctermbg=238 ctermfg=188 cterm=None
hi User3 ctermbg=234 ctermfg=188 cterm=None
hi User4 ctermbg=124 ctermfg=188 cterm=None

hi ExtraWhitespace ctermbg=9 ctermfg=15 cterm=None

" Messes with html titles and I can't be bothered to manually reassign those
" Also, Title was originally set only for the default tabline which is no
" longer in use anyway
"
" hi Title ctermfg=16 ctermbg=68 cterm=None
hi TabLineFill ctermfg=16 ctermbg=0 cterm=None
hi TabLine ctermfg=188 ctermbg=238 cterm=None
hi TabLineSel ctermfg=16 ctermbg=68 cterm=None

hi StatusLine ctermbg=68 ctermfg=16 cterm=None
hi StatusLineTerm ctermbg=68 ctermfg=16 cterm=None
hi StatusLineNC ctermbg=234 ctermfg=188 cterm=None
hi StatusLineTermNC ctermbg=234 ctermfg=188 cterm=None

hi VertSplit ctermbg=238 ctermfg=68 cterm=None

hi CursorLine cterm=None
hi CursorLineNr ctermfg=11 cterm=None

hi ColorColumn ctermbg=124 ctermfg=188 cterm=None

hi Conceal ctermfg=11 ctermbg=0 cterm=None

hi Visual ctermfg=0 ctermbg=10 cterm=None

" Trailing Whitespace highlighting
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Status Line
set laststatus=2
set statusline=%!statusline#MyStatusLine()

" Tab Line
set showtabline=2
set tabline=%!tabline#MyTabLine()

" Fillchars (lines between windows)
set fillchars=vert:\ 

" NERDTree is not for me
let g:netrw_liststyle=0
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_fastbrowse=2
let g:netrw_bufsettings="noma nomod nobl nowrap ro nu rnu"
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

" 3/10/2019: I never actually use this bind; changing it to open a tab
"            instead, which happens much more frequently...
" nnoremap <C-> :vs. <bar> vertical res 25 <CR>

"""""""""""
" Keymaps "
"         "
"""""""""""
cabbrev w!! w !sudo tee > /dev/null %:p
map <Enter> o<esc>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Works with fat fingers holding down control...
inoremap <C-@> <Space>

" Toggle Relative Line Numbers
nnoremap <silent> <C-l> :set relativenumber!<CR>

" Toggle ColorColumn
autocmd BufWinEnter * set cc=

fun! ToggleCC()
  if &cc == ''
    set cc=81
  else
    set cc=
  endif
endfun

nnoremap <silent> <C-k> :call ToggleCC()<CR>

" Move By Displayed Line
" 8/14/19 - this is actually annoying, commenting out
"noremap <silent> k gk
"noremap <silent> j gj
"noremap <silent> ^ g^
"noremap <silent> $ g$
"
"onoremap <silent> k k
"onoremap <silent> j j
"onoremap <silent> ^ ^
"onoremap <silent> $ $

" Move In Insert Mode
" inoremap <C-l> <Esc><Right>a
" inoremap <C-h> <Esc><Left>a

" Tabs
" Switch to last-active tab
if !exists('g:ptab')
    let g:ptab = 1
    let g:ptab_backup = 1
endif
autocmd! TabLeave * let g:ptab_backup = g:ptab | let g:ptab = tabpagenr()
autocmd! TabClosed * let g:ptab = g:ptab_backup
nnoremap T :exe "tabn " . g:ptab<CR>

" Remove trailing whitespaces
vnoremap <silent> gw :s/\%V\s\+$//e<CR>

nnoremap <C-n> :tabnew.<CR>
nnoremap gf :tablast<CR>
nnoremap gF :tabfirst<CR>
nnoremap gl :tabm +<CR>
nnoremap gh :tabm -<CR>
nnoremap gm :tabm<Space>
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
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     "
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     '
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
