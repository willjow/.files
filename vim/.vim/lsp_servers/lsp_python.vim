let g:lspServers += [
    \   #{
    \     name: 'basedpyright',
    \     filetype: ['python'],
    \     path: 'basedpyright-langserver',
    \     args: ['--stdio'],
    \     features: #{
    \       codeAction: v:false,
    \       documentFormatting: v:false,
    \     },
    \     workspaceConfig: #{
    \       disableOrganizeImports: v:true,
    \     },
    \   },
    \   #{
    \     name: 'ruff',
    \     filetype: ['python'],
    \     path: 'ruff',
    \     args: ['server'],
    \     workspaceConfig: #{
    \       lineLength: 79,
    \       lint: #{
    \         extendSelect: ['ALL'],
    \       },
    \     },
    \   },
    \ ]
