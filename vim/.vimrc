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


"""""""""""""""
" Directories "
"             "
"""""""""""""""
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set viewdir=~/.vim/view//


""""""""""""""""""""
" 'Basic' Settings "
"                  "
""""""""""""""""""""
filetype plugin on
syntax enable

set number relativenumber
set ignorecase
set smartcase
set wrap lbr sms
set report=0
set display+=truncate
set scrolloff=12
set cursorline
set nocursorcolumn
set noshowcmd
set incsearch
let maplocalleader="\<Tab>"
let mapleader="\<Space>"

" Enable scrolling
set mouse=nvc
set ttymouse=xterm2

" VirtualEdit
set virtualedit=block

" Wildmenu
set wildmenu
set wildmode=full
set wildoptions=fuzzy,pum

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
set formatoptions=qnl1jtcro
set nojoinspaces

" Toggle Text Autoformatting
function AutoFormatOn()
  set formatoptions+=tcro
  nnoremap <leader>af :call AutoFormatOff()<CR>
endfunction

function AutoFormatOff()
  set formatoptions-=tcro
  nnoremap <leader>af :call AutoFormatOn()<CR>
endfunction

nnoremap <leader>af :call AutoFormatOff()<CR>

" set tabs to 2 for certain files
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ColorScheme
set t_Co=256
set cc=
colorscheme darkblueOG
highlight Normal ctermbg=16
let &t_ut=''

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
"   234     Grey11      (28, 28, 28)
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

hi CursorLine ctermbg=234 ctermfg=None cterm=None
hi CursorLineNr ctermbg=234 ctermfg=11 cterm=None

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


""""""""""""
" Commands "
"          "
""""""""""""
cabbrev w!! w !sudo tee > /dev/null %:p


"""""""""""
" Keymaps "
"         "
"""""""""""
noremap <Enter> o<esc>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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

" Works with fat fingers holding down control...
inoremap <C-@> <Space>

" Toggle Relative Line Numbers
nnoremap <silent> <leader>rl :set relativenumber!<CR>

" Toggle color column limit indicator
autocmd BufWinEnter * set cc=

fun! ToggleCL()
  if &cc == ''
    set cc=80
  else
    set cc=
  endif
endfun

nnoremap <silent> <leader>cl :call ToggleCL()<CR>

" Press CTRL-/ to toggle search highlighting on/off and show current value.
set nohlsearch
nnoremap <leader>hl :set hlsearch! hlsearch?<CR>

" Join
noremap Q J

" Macro over visual selection
function! ExecuteMacroOverVisualRange()
  echo "@"
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

vnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Buffers
nnoremap gB :b #<CR>

" Tabs
" Switch to last-active tab
if !exists('g:ptab')
  let g:ptab = 1
  let g:ptab_backup = 1
endif
autocmd! TabLeave * let g:ptab_backup = g:ptab | let g:ptab = tabpagenr()
autocmd! TabClosed * let g:ptab = g:ptab_backup
nnoremap gT :exe "tabn " . g:ptab<CR>
nnoremap <C-n> :tabnew.<CR>
nnoremap gf :tablast<CR>
nnoremap gF :tabfirst<CR>
nnoremap gl :tabm +<CR>
nnoremap gh :tabm -<CR>
nnoremap gm :tabm<Space>
nnoremap J  :tabn<CR>
nnoremap K  :tabp<CR>

" Quickfix/Location list
packadd cfilter

command! QuickFixToLocList call setloclist(0, getqflist())
command! LocListToQuickFix call setqflist(getloclist(0))

nnoremap <leader>ql :QuickFixToLocList<CR> :cclose<CR> :lopen<CR>

function! RemoveLineFromQuickFix(line)
  let l:line = a:line - 1
  call setqflist(filter(getqflist(), "v:key['lnum'] != l:line"))
endfunction

function! RemoveLineFromLocList(line)
  let l:line = a:line - 1
  call setloclist(0, filter(getloclist(0), "v:key['lnum'] != l:line"))
endfunction

nnoremap <leader>qd :call RemoveLineFromQuickFix(line("."))<CR>
nnoremap <leader>ld :call RemoveLineFromLocList(line("."))<CR>

nnoremap <leader>cc :.cc<CR>

nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>

" Remove trailing whitespaces
vnoremap <silent> gw :s/\%V\s\+$//e<CR>

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


"""""""""""
" Plugins "
"         "
"""""""""""
" vim-plug
" --------
call plug#begin('~/.vim/plugged')

" general
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" filetype-specific
Plug 'lervag/vimtex'
Plug 'andymass/vim-matchup'
Plug 'jalvesaq/Nvim-R'

call plug#end()


" fzf
" ---
function CD(...)
  call fzf#run(fzf#wrap({
    \'source': 'command fd --type d --hidden --follow --exclude ".git" . '.(a:0 == 0 ? getcwd() : a:1),
    \'sink': 'cd'
  \}))
endfunction
command! -nargs=* CD call CD(<q-args>)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" fuzzy
nnoremap <C-j> :Rg!<CR>
" full-word
nnoremap <leader>j :RG!<CR>
nnoremap <C-k> :Files!<CR>


" lsp
" ---
source ~/.vim/config/lspservers.vim
autocmd VimEnter * call LspAddServer(g:lspServers)

let g:lspOpts = #{
    \   autoComplete: v:true,
    \   autoHighlight: v:false,
    \   autoHighlightDiags: v:false,
    \   autoPopulateDiags: v:false,
    \   diagVirtualTextAlign: 'below',
    \   hoverInPreview: v:false,
    \   noDiagHoverOnLine: v:false,
    \   showDiagInPopup: v:true,
    \   showDiagOnStatusLine: v:false,
    \   showDiagWithVirtualText: v:true,
    \   showInlayHints: v:false,
    \   showSignature: v:true,
    \   ultisnipsSupport: v:true,
    \   useBufferCompletion: v:true,
    \   usePopupInCodeAction: v:false,
    \   useQuickfixForLocations: v:false,
    \ }
autocmd VimEnter * call LspOptionsSet(g:lspOpts)

nnoremap <leader>ac :LspCodeAction<CR>
nnoremap <leader>ff :LspFormat<CR>
vnoremap <leader>ff :LspFormat<CR>
nnoremap <leader>df :LspGotoDefinition<CR>
nnoremap <leader>dc :LspGotoDeclaration<CR>
nnoremap <leader>im :LspGotoImpl<CR>
nnoremap <leader>ty :LspGotoTypeDef<CR>
nnoremap <leader>hv :LspHover<CR>
nnoremap <leader>rf :LspShowReferences<CR>

" Toggle Diagnostic Highlight
function LspDiagnosticHighlightOn()
  LspDiagHighlightEnable
  nnoremap <leader>hd :call LspDiagnosticHighlightOff()<CR>
endfunction

function LspDiagnosticHighlightOff()
  LspDiagHighlightDisable
  nnoremap <leader>hd :call LspDiagnosticHighlightOn()<CR>
endfunction

nnoremap <leader>hd :call LspDiagnosticHighlightOn()<CR>


" ultisnips
" ---------
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnippets/']
let g:UltiSnipsListSnippets="<C-u>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
nnoremap <leader>ur :call UltiSnips#RefreshSnippets()<CR>


" vimtex
" ------
" autocmd FileType tex setlocal spell spelllang=en_us
let g:tex_flavor='latex'
let g:vimtex_view_use_temp_files=1
let g:vimtex_view_method='zathura'
let g:vimtex_matchparen_enabled=1
let g:matchup_override_vimtex=1
let g:matchup_matchparen_deferred=1
let g:matchup_matchparen_offscreen={}
let g:vimtex_syntax_conceal = #{
    \   accents: 1,
    \   ligatures: 1,
    \   cites: 1,
    \   fancy: 1,
    \   spacing: 1,
    \   greek: 1,
    \   math_bounds: 1,
    \   math_delimiters: 1,
    \   math_fracs: 1,
    \   math_super_sub: 0,
    \   math_symbols: 1,
    \   sections: 0,
    \   styles: 1,
    \ }


" tex-conceal
" -----------
set conceallevel=2
let g:tex_conceal='abdmg'


" Nvim-R
" ------
let R_in_buffer=0
let R_term='urxvt'
let R_openhtml=1
let R_openpdf=1
let R_assign=0
