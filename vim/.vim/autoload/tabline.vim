" Here's a text-style tabline for both Console and GUI modes;
" it displays before each filename something like  3:4/8, meaning
" "Tab 3, window 4 of 8". These numbers are in "User1" highlight,
" or "User2" for the current tab, while the TabLine, TabLineSel
" and TabLineFill highlight groups have their usual meanings, see
" :help setting-tabline. You may want to set the colours in a
" colorscheme, possibly an owncoded one, but that is not the
" topic of this tip.
"
" [...]
"
" This function is not perfect: the name for a netrw directory
" appears as [No Name], just like for an unnamed buffer. Feel
" free to enhance it if you can.
"
" --- Tonymec 22:49, August 14, 2010 (UTC)
" https://vim.fandom.com/wiki/Show_tab_number_in_your_tab_line
"
" ("enhanced" version as follows...)
let s:s_col = '%1*'
let s:t_col = '%2*'

function! tabline#MyTabLine()
    let l:s = ''
    let l:t = tabpagenr()
    let l:i = 1

    while l:i <= tabpagenr('$')
        let l:buflist = tabpagebuflist(i)
        let l:winnr = tabpagewinnr(i)
        let l:totnr = tabpagewinnr(i, '$')
        let l:bufnr = buflist[winnr - 1]
        " set the tab page number for mouse clicks
        let l:s .= '%' . l:i . 'T'
        let l:s .= tabline#GetTabColor(l:i, l:t)
        let l:s .= tabline#TabModified(l:buflist, l:i, l:t)
        let l:s .= l:i . ':'
        let l:s .= ' '
        let l:s .= tabline#TabSplits(l:winnr, l:totnr)
        let l:s .= tabline#FileName(l:bufnr)
        let l:s .= ' '
        let l:i = l:i + 1
    endwhile

    let l:s .= '%T'
    let l:s .= '%#TabLineFill#'
    " let l:s .= tabline#GetLineColor(l:i)
    " let l:s .= '%='
    " let l:s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return l:s
endfunction

function! tabline#GetTabColor(i, t)
    return (a:i == a:t ? s:s_col : s:t_col)
endfunction

function! tabline#TabModified(bl, i, t)
    for l:b in a:bl
        if getbufvar(l:b, '&modified')
            return ' + '
        endif
    endfor
    return ' '
endfunction

function! tabline#TabSplits(wn, tn)
    return (a:tn == 1 ? '' : a:wn . '/' . a:tn . ' ')
endfunction

function! tabline#FileName(bn)
    let l:file = bufname(a:bn)
    let l:filetype = getbufvar(a:bn, '&filetype')

    if l:filetype == 'netrw'
        let l:file = fnamemodify(l:file, ':p')
        let l:file = substitute(l:file, $HOME, '~', '')
        let l:file = substitute(l:file, '\/$', '', '')
        let l:file = substitute(l:file, '[\/\~][^\/\~]\zs[^\/\~]\+\ze\/', '', 'g')
        let l:file .= '/'
    else
        let l:file = fnamemodify(l:file, ':p:t')
    endif

    if l:file == ''
        let l:file = '[No Name]'
    endif

    return l:file
endfunction
