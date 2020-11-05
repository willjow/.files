" Colors
let s:main_col = '%1*'
let s:fill_col = '%2*'
let s:dark_col = '%3*'
let s:warn_col = '%4*'

function! statusline#MyStatusLine()
    " Note: The returned string is fixed and evaluated later,
    " for each window. Consequently, local variables defined
    " in the string won't be resolved.
    let l:s = ''
    let l:s .='%<'
    " TODO make it so that if the window isn't focused, the
    " file path is highlighted with s:dark_col instead of
    " with s:main_col
    "
    " 3/10/2019 This effect has been cheesed by abusing the
    " fact that setting highlights StatusLine[Term] and
    " StatusLine[Term]NC seem to affect color values set
    " here only if they're equal (fg and bg) to the values
    " defined for the highlights.
    " (e.g., set StatusLine[Term] = s:main_col)
    let l:s .= s:main_col
    let l:s .= ' %F '
    let l:s .= s:dark_col
    let l:s .= '%{statusline#BufferType()}'
    let l:s .= s:warn_col
    let l:s .= '%{statusline#Warnings()}'
    let l:s .= s:fill_col
    let l:s .= '%='
    let l:s .= ' %{&fileformat}, '
    let l:s .= '%{strlen(&fenc)? &fenc : &enc} '
    let l:s .= s:dark_col
    let l:s .= ' %{statusline#Col()}, %l/%L '
    return l:s
endfunction

function! statusline#BufferType()
    let l:padl = ' ['
    let l:padr = '] '
    let l:bn = bufnr('%')
    let l:bt = getbufvar(l:bn, '&buftype')
    let l:ft = getbufvar(l:bn, '&filetype')
    let l:s = ''

    if l:bt == 'nofile'
        let l:s = 'nofile'

    elseif l:bt == 'nowrite'
        let l:s = 'nowrite'

    elseif l:bt == 'acwrite'
        let l:s = 'acwrite'

    elseif l:bt == 'quickfix'
        if getwininfo(win_getid())[0]['loclist']
            let l:s = 'loclist'
        else
            let l:s = 'quickfix'
        endif

    elseif l:bt == 'help'
        let l:s = 'help'

    elseif l:bt == 'terminal'
        let l:s = 'terminal'

    elseif l:bt == 'prompt'
        let l:s = 'prompt'

    elseif getbufvar(l:bn, '$previewwindow')
        let l:s = 'preview'

    elseif l:ft != ''
        let l:s = l:ft

    endif

    return (l:s == '' ? l:s : l:padl . l:s . l:padr)
endfunction

function! statusline#Warnings()
    " TODO sketchy workaround to deal with the statusline
    " eating the leading space when following a nonempty
    " value for statusline#BufferType (for reasons unknown
    " at the current point in time)
    let l:padl = (statusline#BufferType() == '' ? ' ' : '  ')
    let l:padr = ' '
    let l:ro = statusline#ReadOnly()
    let l:mod = statusline#Modified()
    if l:ro != '' && l:mod != ''
        let l:s = l:ro . ' ' . l:mod
    else
        let l:s = l:ro  . l:mod
    endif
    return (l:s == '' ? l:s : l:padl . l:s . l:padr)
endfunction

function! statusline#ReadOnly()
    return (&readonly || !&modifiable ? '[RO]' : '')
endfunction

function! statusline#Modified()
    if glob(expand('%p')) == ''
        return '[New File]'
    elseif &modified
        return '+'
    else
        return ''
    endif
endfunction

function! statusline#FileSize()
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1024.0
    endif
    if (exists('kbytes') && l:kbytes >= 1024)
        let l:mbytes = l:kbytes / 1024.0
    endif
    if (exists('mbytes') && l:mbytes >= 1024)
        let l:gbytes = l:mbytes / 1024.0
    endif

    if l:bytes <= 0
        let l:bytes = 0
    endif

    if (exists('gbytes'))
        return printf(' %.2f GB ', l:gbytes)
    elseif (exists('mbytes'))
        return printf(' %.1f MB ', l:mbytes)
    elseif (exists('kbytes'))
        return printf(' %.1f KB ', l:kbytes)
    else
        return printf(' %.0f B ', l:bytes)
    endif
endfunction

function! statusline#Col()
    let l:bytecol = col('.')
    let l:screencol = virtcol('.')
    if l:bytecol != l:screencol
        return l:bytecol . ' (' . l:screencol . ')'
    else
        return l:bytecol
endfunction

function! statusline#Words()
    return wordcount()['words'] . ' W '
endfunction
