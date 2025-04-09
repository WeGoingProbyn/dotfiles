#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source .bashrc.d scripts
if [[ -d $HOME/.bashrc.d ]]; then
  for f in $HOME/.bashrc.d/*; do
    # ignore path variables
    if [[ $f != $HOME/.bashrc.d/paths.sh ]]; then
      source "$f"
    fi
  done
  # cleanup f from shell variables
  unset f
fi

# Bash prompt
# PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
