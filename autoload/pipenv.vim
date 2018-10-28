" pipenv-vim core commands
" Version: 0.2.0

function! pipenv#command(...)
    let action = a:0 > 0 ? a:1 : ''
    if len(action) != 0
        if action == 'disable'
            let g:pipenv_activated = 0
            call virtualenv#deactivate()
            return
        endif
        if action == 'enable'
            call pipenv#activate(1)
            return
        endif
        echo "Executing pipenv " . action . " ..."
        let output=systemlist("pipenv " . action)
        for line in output
            echom line
        endfor
    else
        " If no command, activate pipenv of currently selected buffer
        call pipenv#activate(1)
    endif
endfunction

function! pipenv#enable_auto()
    autocmd filetype python call pipenv#activate()
endfunction

function! pipenv#debug(Wow)
    echomsg "event: " . a:Wow
endfunction

function! pipenv#activate(...)
    let force = a:0 > 0 ? 1 : 0
    if !exists("g:virtualenv_loaded")
        echoerr "vim-virtualenv not found, pipenv venv activation disabled"
        return
    endif
    if g:pipenv_activated == 0
        " No pipenv yet: try to load one from the current file
        let g:pipenv_activated = 1
        let venv_path = system('sh -c "export PIPENV_IGNORE_VIRTUALENVS=1;export PIPENV_VERBOSITY=-1; cd ' . expand('%:p:h') . '; pipenv --venv"')
        if shell_error == 0
            let venv_name = substitute(venv_path, '\(\/.\+\/\|\n\|\r\)', '', '') 
            let venv_name = substitute(venv_name, '\n\+$', '', '')
            let g:venv_name = venv_name
            call virtualenv#activate(g:venv_name)
        endif
    else
        " Already a pipenv active, check if still the same
        if g:pipenv_auto_switch == 0 && force == 0
            return
        endif
        let venv_path = system('sh -c "export PIPENV_IGNORE_VIRTUALENVS=1;export PIPENV_VERBOSITY=-1; cd ' . expand('%:p:h') . '; pipenv --venv"')
        if shell_error == 0
            let venv_name = substitute(venv_path, '\(\/.\+\/\|\n\|\r\)', '', '') 
            let venv_name = substitute(venv_name, '\n\+$', '', '')
            if venv_name != g:venv_name
                " Other venv detected, switch!
                let g:venv_name = venv_name
                call virtualenv#activate(g:venv_name)
            endif
        endif
    endif
endfunction
