let g:lspServers += [
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
