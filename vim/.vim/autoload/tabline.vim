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

" Note: ensure that s:s_col != s:t_col
let s:s_col = '%1*'
let s:t_col = '%2*'
let s:d_col = '%3*'
let s:stab_pat = '%\d\+T' . substitute(s:s_col, '\*', '\\*', '')
let s:ttab_pat = '%\d\+T' . substitute(s:t_col, '\*', '\\*', '')
let s:tab_pat = '%\d\+T%\d\*'
let s:end_pat = '%T%#TabLineFill#.*'

function! tabline#MyTabLine()
    let l:s = ''
    let l:t = tabpagenr()
    let l:i = 1

    while l:i <= tabpagenr('$')
        let l:buflist = tabpagebuflist(i)
        let l:winnr = tabpagewinnr(i)
        let l:totnr = tabpagewinnr(i, '$')
        let l:bufnr = buflist[winnr - 1]
        let l:s .= '%' . l:i . 'T' " tab number for mouse clicks
        let l:s .= tabline#GetTabColor(l:i, l:t)
        let l:s .= tabline#TabModified(l:buflist, l:i, l:t)
        let l:s .= l:i . ':'
        let l:s .= ' '
        let l:s .= tabline#TabSplits(l:winnr, l:totnr)
        let l:s .= tabline#BufferName(l:bufnr)
        let l:s .= ' '
        let l:i = l:i + 1
    endwhile

    let l:s .= '%T'
    let l:s .= '%#TabLineFill#'
    let l:s .= '%='
    let l:s .= s:d_col
    let l:s .= ' '
    let l:s .= tabline#GetCWD()
    let l:s .= ' '
    return l:s
endfunction

function! tabline#Truncate(tabs)
    " Truncate tabline so that the current tab is always visible
    " TODO figure out what you actually want to do here before
    " writing any more garbage
    let l:t = a:tabs
    if (strlen(tabline#DisplayText(l:t)) > &columns)
        let l:cutl_pat = '.*\ze\(' . s:ttab_pat . '.\{-}\)\{2}' . s:stab_pat
        let l:cutr_pat = s:stab_pat
        let l:cutr_pat .= '.\{-}\(' . s:ttab_pat . '.\{-}\)\{,2}'
        let l:cutr_pat .= '\zs' . s:ttab_pat . '.*'
        let l:t = substitute(a:tabs, l:cutr_pat, '', '')
    endif
    return l:t
endfunction

function! tabline#ElementList(tabs)
    let l:tabs = tabline#TabList(a:tabs)
    let l:end = substitute(a:tabs, '.*%=', '', '')
    return l:tabs + [l:end]
endfunction

function! tabline#TabList(tabs)
    let l:tabs = substitute(a:tabs, s:end_pat, '', '')
    let l:tlist = split(l:tabs, '\ze' . s:tab_pat . '.*')
    return l:tlist
endfunction

function! tabline#DisplayText(tabs)
    let l:dtext = substitute(a:tabs, s:tab_pat, '', 'g')
    let l:dtext = substitute(l:dtext, s:end_pat, '', '')
    return l:dtext
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

function! tabline#BufferName(bn)
    let l:bname = bufname(a:bn)
    let l:bt = getbufvar(a:bn, '&buftype')
    let l:ft = getbufvar(a:bn, '&filetype')

    if l:ft == 'netrw'
        let l:bname = fnamemodify(l:bname, ':p')
        let l:bname = tabline#ShortenParents(l:bname)
    elseif l:bt == 'quickfix'
        if getwininfo(win_getid())[0]['loclist']
            let l:bname = '[loclist]'
        else
            let l:bname = '[quickfix]'
        endif
    else
        let l:bname = fnamemodify(l:bname, ':p:t')
    endif

    if l:bname == ''
        let l:bname = '[No Name]'
    endif

    return l:bname
endfunction

function! tabline#ShortenParents(fp)
    let l:sfp = substitute(a:fp, $HOME, '~', '')
    let l:sfp = substitute(l:sfp, '\/$', '', '')
    let l:sfp = substitute(l:sfp, '[\/\~][^\/\~]\zs[^\/\~]\+\ze\/', '', 'g')
    let l:sfp .= '/'
    return l:sfp
endfunction

function! tabline#GetCWD()
    let l:cwd = getcwd()
    let l:cwd = fnamemodify(l:cwd, ':p')
    let l:cwd = tabline#ShortenParents(l:cwd)
    return l:cwd
endfunction
