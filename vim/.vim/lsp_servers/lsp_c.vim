let g:lspServers += [
    \   {
    \     'name': 'clangd',
    \     'filetype': ['c', 'cpp'],
    \     'path': 'clangd',
    \     'args': ['--background-index', '--clang-tidy'],
    \   },
    \ ]
