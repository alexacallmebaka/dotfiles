#if not running interactively, don't do anything
[[ $- != *i* ]] && return

#disables ctrl + s lockup
stty -ixon

#custom prompts
PS1='\[\e[31m\][\[\e[96m\]\u\[\e[35m\]@\[\e[33m\]\h \[\e[92m\]\W\[\e[94m\]]\[\e[37m\]\$\[\e[00m\] '
PS2='\[\e[1;102;31m\]-->\[\e[00m\] '

#make aliases work under sudo
alias sudo='sudo '

#aliases

#i3wm
alias vii3='$EDITOR $XDG_CONFIG_HOME/i3/config'

#programs
alias waifu2x='waifu2x-ncnn-vulkan'
alias ls='ls --color=auto'
#alias spotify='flatpak run com.spotify.Client'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
alias ll='ls -l'
alias la='ls -A'

#so ssh plays nicely with alacritty when remote systems don't have my terminfo.
alias ssh='TERM=xterm-256color ssh'
alias rm='trash'
alias vivi='vim $HOME/.vim/vimrc'

alias lf='$XDG_CONFIG_HOME/lf/lfwrapper'

#Clean up home directory
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

alias dfm='git --git-dir=$HOME/.dotfiles_manager --work-tree=$HOME'

source $HOME/.local/miniconda3/conda_init.bash
