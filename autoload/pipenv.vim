" pipenv-vim core commands
" Version: 0.3.1

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
    autocmd BufWinEnter *.py call pipenv#notify()
endfunction

function! pipenv#debug(Wow)
    echomsg "vim-pipenv | event: " . a:Wow
endfunction

function! pipenv#notify(...)
    if !exists("g:virtualenv_loaded")
        return
    endif
    if g:pipenv_notify == 1
        let clean_text = substitute(g:pipenv_path, '[[:cntrl:]]', '', 'g')
        echomsg "vim-pipenv | Activated venv: " . clean_text 
        let g:pipenv_notify = 0
    endif
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
        let l:venv_path = system('sh -c "export PIPENV_IGNORE_VIRTUALENVS=1;export PIPENV_VERBOSITY=-1; cd ' . expand('%:p:h') . '; pipenv --venv"')
        if shell_error == 0
            let g:venv_name = fnamemodify(l:venv_path, ':p:t:gs?[[:cntrl:]]??')
            call virtualenv#activate(g:venv_name)
            let g:pipenv_activated = 1
            let g:pipenv_notify = 1
            let g:pipenv_path = l:venv_path
        endif
    else
        " Already a pipenv active, check if still the same
        if g:pipenv_auto_switch == 0 && force == 0
            return
        endif
        let l:venv_path = system('sh -c "export PIPENV_IGNORE_VIRTUALENVS=1;export PIPENV_VERBOSITY=-1; cd ' . expand('%:p:h') . '; pipenv --venv"')
        if shell_error == 0
            let l:venv_name = fnamemodify(l:venv_path, ':p:t:gs?[[:cntrl:]]??')
            if l:venv_name != g:venv_name
                " Other venv detected, switch!
                let g:venv_name = l:venv_name
                call virtualenv#activate(g:venv_name)
                let g:pipenv_notify = 1
                let g:pipenv_path = l:venv_path
            endif
        endif
    endif
endfunction
