#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias n="nvim"
alias intellij="intellij-idea-ultimate-edition"

source /usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_COMMAND="sudo fd --type f --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="sudo fd --type d --hidden"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
