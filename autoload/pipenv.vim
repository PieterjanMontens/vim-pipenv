function! pipenv#command(...)
    let action = a:0 > 0 ? a:1 : ''
    if len(action) != 0
        echo "Executing pipenv " . action . " ..."
        let output=systemlist("pipenv " . action)
        for line in output
            echom line
        endfor
    else
        echoerr "No command given to :Pipenv"
    endif
endfunction

function! pipenv#enable_auto()
    autocmd filetype python call pipenv#activate()
endfunction

function! pipenv#activate()
    if !exists("g:virtualenv_loaded")
        echoerr "vim-virtualenv not found, pipenv venv activation disabled"
        return
    endif
    if !exists("g:pipenv_activated")
        let g:pipenv_activated = 1
        let venv_path = system('pipenv --venv')
        if shell_error == 0
            let venv_name = substitute(venv_path, '\(\/.\+\/\|\n\)', '', '') 
            execute("VirtualEnvActivate " . venv_name)
        endif
    endif
endfunction
