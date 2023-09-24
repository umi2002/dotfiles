#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=$PATH:/home/umi/.spicetify
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi

export EDITOR=nvim

export MANPATH=$MANPATH:/usr/local/texlive/2023/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2023/texmf-dist/doc/info

export PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH
export PATH=/home/umi/.cargo/bin:$PATH
export PATH=/opt/Xilinx/Vivado/2023.1/bin:$PATH

# Created by `pipx` o/ 2023-06-29 22:01:34
export PATH="$PATH:/home/umi/.local/bin"

PATH="/home/umi/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/umi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/umi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/umi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/umi/perl5"; export PERL_MM_OPT;
