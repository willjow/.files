" Configure LSP servers here to avoid vimrc clutter
let g:lspServers = [
    \   #{
    \     name: 'clangd',
    \     filetype: ['c', 'cpp'],
    \     path: '/usr/bin/clangd',
    \     args: ['--background-index'],
    \   },
    \   #{
    \     name: 'python-lsp-server',
    \     filetype: ['python'],
    \     path: '/usr/bin/pylsp',
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
    \           mccabe: #{
    \             enabled: v:false,
    \           },
    \           pyls_isort: #{
    \             enabled: v:true,
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
    \ #{
    \    name: 'rustlang',
    \    filetype: ['rust'],
    \    path: '/usr/bin/rust-analyzer',
    \    args: [],
    \    syncInit: v:true,
    \    initializationOptions: #{
    \      cargo: #{
    \        buildScripts: #{
    \          enable: v:true,
    \        },
    \      },
    \      procMacro: #{
    \        enable: v:true,
    \      },
    \    },
    \  },
    \ ]
