#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=/usr/bin/:$PATH
export PATH=/home/umi/.cargo/bin:$PATH
export PATH=/usr/share/perl5/site_perl/:$PATH
export PATH=/home/umi/.local/share/gem/ruby/3.0.0/bin/:$PATH
export PATH=/home/umi/Desktop/serieViaUSB:$PATH
export PATH=/home/umi/.local/bin:$PATH

export FZF_DEFAULT_COMMAND='find .'
export FZF_ALT_C_COMMAND='command find .'
export FZF_CTRL_T_COMMAND='command find .'
export EDITOR="neovim"
export VISUAL="neovim"
export GBM_BACKEND="nvidia-drm"
export __GLX_VENDOR_LIBRARY_NAME="nvidia"
export LIBSEAT_BACKEND=logind
export WLR_NO_HARDWARE_CURSORS=1
export QT_QPA_PLATFORM=wayland

alias clang-format="/home/umi/scripts/clang-format.sh"
