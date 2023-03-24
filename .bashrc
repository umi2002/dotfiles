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
export PATH=/root/.local/share/gem/ruby/3.0.0/bin:$PATH
export PATH=/home/umi/Desktop/serieViaUSB:$PATH
export FZF_DEFAULT_COMMAND='find .'
export FZF_ALT_C_COMMAND='command find .'
