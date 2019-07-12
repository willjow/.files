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

" Note: ensure that s:main_col != s:back_col
let s:main_col = '%1*'
let s:back_col = '%2*'
let s:fill_col = '%3*'
let s:main_pat = '%\d\+T' . substitute(s:main_col, '\*', '\\*', '')
let s:back_pat = '%\d\+T' . substitute(s:back_col, '\*', '\\*', '')
let s:tab_pat = '%\d\+T%\d\*'
let s:end_pat = '%T' . s:fill_col . '.*'

function! tabline#MyTabLine()
    let l:s = ''
    let l:t = tabpagenr()
    let l:i = 1

    while l:i <= tabpagenr('$')
        let l:buflist = tabpagebuflist(i)
        let l:winnr = tabpagewinnr(i)
        let l:totnr = tabpagewinnr(i, '$')
        let l:bufnr = buflist[winnr - 1]
        let l:s .= '%' . l:i . 'T'
        let l:s .= tabline#TabColor(l:i, l:t)
        let l:s .= tabline#TabModified(l:buflist, l:i, l:t)
        let l:s .= l:i . ':'
        let l:s .= ' '
        let l:s .= tabline#TabSplits(l:winnr, l:totnr)
        let l:s .= tabline#BufferName(l:bufnr)
        let l:s .= ' '
        let l:i = l:i + 1
    endwhile

    let l:s .= '%T'
    let l:s .= s:fill_col
    let l:s .= '%='
    let l:s .= ' '
    let l:s .= tabline#GetCWD()
    let l:s .= ' '
    " truncate tab text (l:s) here, before returning
    
    return l:s
endfunction

function! tabline#Truncate(tabs)
    " Truncate tabline so that the current tab is always visible
    " TODO: figure out what you actually want to do here before
    "       writing any more garbage
    "
    "       Potential schemes:
    "           1) truncate non-active tabs to be just the number and
    "              first letter (don't worry about cutting any other text
    "              e.g., to the left or right, because if you have too many
    "              tabs open with this scheme you're doing something wrong)
    "
    "           2) keep full length tab names and put <, > on the
    "              clipping boundaries
    "
    "              Obstacle: figure out how to clip the boundaries such that
    "                        current tab is intelligently centered
    let l:t = a:tabs
    if (strlen(tabline#DisplayText(l:t)) > &columns)
        " Broken start to scheme (2)
        " let l:cutl_pat = '.*\ze\(' . s:back_pat . '.\{-}\)\{2}' . s:main_pat
        " let l:cutr_pat = s:main_pat
        " let l:cutr_pat .= '.\{-}\(' . s:back_pat . '.\{-}\)\{,2}'
        " let l:cutr_pat .= '\zs' . s:back_pat . '.*'
        " let l:t = substitute(a:tabs, l:cutr_pat, '', '')
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

function! tabline#TabColor(i, t)
    return (a:i == a:t ? s:main_col : s:back_col)
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
