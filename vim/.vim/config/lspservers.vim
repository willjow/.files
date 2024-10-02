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
    \         }
    \       },
    \       javascript: #{
    \         format: #{
    \           indentSize: 4,
    \         }
    \       },
    \     },
    \   },
    \   #{
    \     name: 'python-lsp-server',
    \     filetype: ['python'],
    \     path: 'pylsp',
    \     args: [],
    \     workspaceConfig: #{
    \       pylsp: #{
    \         configurationSources: ['pycodestyle'],
    \         plugins: #{
    \           autopeop8: #{
    \             enabled: v:false,
    \           },
    \           black: #{
    \             enabled: v:true,
    \             line_length: 79,
    \           },
    \           flake8: #{
    \             enabled: v:false,
    \           },
    \           isort: #{
    \             enabled: v:true,
    \             profile: 'black',
    \             line_length: 79,
    \           },
    \           mccabe: #{
    \             enabled: v:false,
    \           },
    \           pylsp_mypy: #{
    \             enabled: v:false,
    \             dmypy: v:true,
    \             live_mode: v:false,
    \           },
    \           pycodestyle: #{
    \             enabled: v:true,
    \             maxLineLength: 79,
    \           },
    \           pydocstyle: #{
    \             enabled: v:false,
    \           },
    \           pyflakes: #{
    \             enabled: v:true,
    \           },
    \           pylint: #{
    \             enabled: v:false,
    \           },
    \           yapf: #{
    \             enabled: v:false,
    \           },
    \         },
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
