function! status#FileSize() abort
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

function! status#Words() abort
    return wordcount()['words'] . ' W '
endfunction

function! status#ReadOnly() abort
    if &readonly || !&modifiable
        return '  [RO] '
    else
        return ''
    endif
endfunction

function! status#Modified() abort
    if glob(expand('%p')) == ""
        return '  [New File] '
    elseif &modified
        return '  + '
    else
        return ''
    endif
endfunction
