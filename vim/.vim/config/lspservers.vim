" Configure LSP servers here to avoid vimrc clutter
let g:lspServers = [
    \   #{
    \     name: 'clangd',
    \     filetype: ['c', 'cpp'],
    \     path: 'clangd',
    \     args: ['--background-index', '--clang-tidy'],
    \   },
    \   #{
    \     name: 'eclipse.jdt.ls',
    \     filetype: ['java'],
    \     path: 'jdtls',
    \     args: [],
    \   },
    \   #{
    \     name: 'tsserver',
    \     filetype: [
    \       'javascript',
    \       'typescript',
    \       'javascriptreact',
    \       'typescriptreact',
    \     ],
    \     path: 'typescript-language-server',
    \     args: ['--stdio'],
    \     workspaceConfig: #{
    \       typescript: #{
    \         format: #{
    \           indentSize: 4,
    \         },
    \       },
    \       javascript: #{
    \         format: #{
    \           indentSize: 4,
    \         },
    \       },
    \     },
    \   },
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
    \   #{
    \     name: 'rustlang',
    \     filetype: ['rust'],
    \     path: 'rust-analyzer',
    \     args: [],
    \     syncInit: v:true,
    \     initializationOptions: #{
    \       cargo: #{
    \         buildScripts: #{
    \           enable: v:true,
    \         },
    \       },
    \       procMacro: #{
    \         enable: v:true,
    \       },
    \     },
    \   },
    \ ]
