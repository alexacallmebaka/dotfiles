export PATH=$PATH:"$HOME/scripts":"$HOME/.local/bin":"$HOME/.cabal/bin"

#default programs
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export PAGER="less"
export READER="zathura"

#GPG stuff
export GPG_TTY=$(tty)

#XDG dirs
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

#clean up home directory
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export HISTFILE="$XDG_CACHE_HOME/bash/history"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export PYTHONHISTFILE="$XDG_CACHE_HOME/python/python_history"

#disable to creation of __pycache__
export PYTHONDONTWRITEBYTECODE=1

#export variables with sensitive info
source $HOME/.bash_profile_private

#source bashrc when running in any interactive shell.
#this is so it will be sourced by things like tmux, which use an interactive login shell.

#if running bash
if [ -n "$BASH_VERSION" ]; then
	
	#include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]
	then
	source "$HOME/.bashrc"
	fi
fi

