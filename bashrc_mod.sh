preferred_shell=
if [ -x $HOME/.local/bin/zsh ]; then
  preferred_shell=$HOME/.local/bin/zsh
fi

if [ -n "$preferred_shell" ]; then
  case $- in
    *i*) SHELL=$preferred_shell; export SHELL; exec "$preferred_shell";;
  esac
fi