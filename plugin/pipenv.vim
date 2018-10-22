if exists("g:pipenv_loaded")
    finish
endif


let g:pipenv_loaded = 1
let s:save_cpo = &cpo
set cpo&vim

if !has('python3') && !has('python')
    finish
endif

if !exists("g:pipenv_auto_activate")
    let g:pipenv_auto_activate = 1
endif

command! -bar -nargs=? -complete=custom,s:CompletePipenv Pipenv :call pipenv#command(<q-args>)

function! s:CompletePipenv(ArgLead, CmdLine, CursorPos)
    " let function = system("pipenv --completion")
    " let what =  system(function)
    return "install\nuninstall\ngraph\nupdate\nsync\nlock" . a:CmdLine . "\n" . a:CursorPos . "\n" . a:ArgLead
endfunction

if g:pipenv_auto_activate == 1
    call pipenv#enable_auto()
endif

let &cpo = s:save_cpo
