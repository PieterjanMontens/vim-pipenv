# pipenv.vim

Inspired by and using [vim-virtualenv](https://github.com/plytophogy/vim-virtualenv), _vim-pipenv_ detects the venv of the pipenv projects you open and activates the corresponding venv.

pipenv-vim will auto-detect the pipenv of any python file you open, and if auto-switching is enabled, will switch to the corresponding venv (see `:help pipenv` for options).

You can also issue commands to pipenv with the `:Pipenv` command, of which the output will be displayed once the command is done (which.. can take some time. Working on it.).


> This is still very much a work in progress, and has only been tested in Linux ;)

_the author_

## Usage Examples ##

Get help

    :help pipenv

See pipenv graph

    :Pipenv graph

Install & lock `pyyaml` in dev packages

    :Pipenv install pyyaml --dev

Activate Pipenv venv for current file

    :Pipenv

`:Pvv` is provided as alias for `:Pipenv`


Use \<tab\> to switch between available commands.

### Installing ###
vim-pipenv depends on the excellent [vim-virtualenv](https://github.com/plytophogy/vim-virtualenv):
make sure you install it too (or just follow guidelines bellow to install both at the same time)

#### Using pathogen ####
First make sure you have [Pathogen](https://github.com/tpope/vim-pathogen), then
```shell
cd ~/.vim
mkdir -p bundle && cd bundle
git clone https://github.com/PieterjanMontens/vim-pipenv
# Install vim-virtualenv as well
git clone https://github.com/plytophogy/vim-virtualenv
```
#### Vundle ####
Using [Vundle](https://github.com/VundleVim/Vundle.vim), install goes like this:

Add these lines to your vundle plugins in your `.vimrc`
```shell
Plugin 'plytophogy/vim-virtualenv'
Plugin 'PieterjanMontens/vim-pipenv'
```
Open vim and run `:PluginInstall`.

### Updating ###
```shell
git -C ~/.vim/bundle/vim-pipenv pull
```

### Removing ###
```shell
rm -rf ~/.vim/bundle/vim-pipenv
```
