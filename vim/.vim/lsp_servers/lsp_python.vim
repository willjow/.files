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
    \       basedpyright: #{
    \         disableOrganizeImports: v:true,
    \       },
    \     },
    \   },
    \   #{
    \     name: 'ruff',
    \     filetype: ['python'],
    \     path: 'ruff',
    \     args: ['server'],
    \     initializationOptions: #{
    \       settings: #{
    \         configuration: #{
    \           line-length: 79,
    \           lint: #{
    \             select: ['ALL'],
    \           },
    \         },
    \         configurationPreference: "filesystemFirst",
    \         showSyntaxErrors: v:false,
    \       },
    \     },
    \   },
    \ ]
