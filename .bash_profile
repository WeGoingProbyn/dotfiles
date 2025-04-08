#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add user defined path variables on login
if [[ -d ~/.bashrc.d ]]; then
  if [[ -f ~/.bashrc.d/paths.sh ]]; then
    source ~/.bashrc.d/paths.sh
  fi
fi
