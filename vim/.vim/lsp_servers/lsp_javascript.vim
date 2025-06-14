let g:lspServers += [
    \   {
    \     'name': 'tsserver',
    \     'filetype': [
    \       'javascript',
    \       'typescript',
    \       'javascriptreact',
    \       'typescriptreact',
    \     ],
    \     'path': 'typescript-language-server',
    \     'args': ['--stdio'],
    \     'workspaceConfig': {
    \       'typescript': {
    \         'format': {
    \           'indentSize': 4,
    \         },
    \       },
    \       'javascript': {
    \         'format': {
    \           'indentSize': 4,
    \         },
    \       },
    \     },
    \   },
    \ ]
