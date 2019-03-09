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
let s_col = '%1*'
let e_col = '%2*'
let o_col = '%3*'

function! tabline#MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1

    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let totnr = tabpagewinnr(i, '$')
        let bufnr = buflist[winnr - 1]
        " set the tab page number for mouse clicks
        let s .= '%' . i . 'T'
        let s .= tabline#GetTabColor(i, t)
        let s .= tabline#TabModified(buflist, i, t)
        let s .= i . ':'
        let s .= ' '
        let s .= tabline#TabSplits(winnr, totnr)
        let s .= tabline#FileName(bufnr)
        let s .= ' '
        let i = i + 1
    endwhile

    let s .= '%T'
    let s .= '%#TabLineFill#'
    " let s .= tabline#GetLineColor(i)
    " let s .= '%='
    " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

function! tabline#GetTabColor(i, t)
    if a:i == a:t
        return '%1*'
    else
        return '%2*'
    endif
endfunction

function! tabline#TabModified(bl, i, t)
    for b in a:bl
        if getbufvar(b, '&modified')
            return ' + '
        endif
    endfor
    return ' '
endfunction

function! tabline#TabSplits(wn, tn)
    if a:tn == 1
        return ''
    else
        return a:wn . '/' . a:tn . ' '
    endif
endfunction

function! tabline#FileName(bn)
    let file = bufname(a:bn)
    let buftype = getbufvar(a:bn, '&buftype')
    if buftype == 'nofile'
        if file =~ '\/.'
            let file = substitute(file, '.*\/\ze.', '', '')
        endif
    else
        let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
        let file = '[No Name]'
    endif
    return file
endfunction
