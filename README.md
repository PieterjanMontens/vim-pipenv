# pipenv.vim

Inspired by and using [vim-virtualenv](https://github.com/plytophogy/vim-virtualenv), _vim-pipenv_ detects the venv of the pipenv projects you open and activates the corresponding venv.

You can also issue commands to pipenv with the `:Pipenv` command, of which the output will be displayed once the command is done (which.. can take some time. Working on it.).

> This is still very much a work in progress ;)

_the author_

## Usage Examples ##

Get help

    :help pipenv

See pipenv graph
    
    :Pipenv graph

Install & lock `pyyaml` in dev packages

    :Pipenv install pyyaml --dev


Use \<tab\> to switch between available commands.

## Installing ##

#### Using pathogen ####
```shell
cd ~/.vim
mkdir -p bundle && cd bundle
git clone https://github.com/PieterjanMontens/vim-pipenv
```

