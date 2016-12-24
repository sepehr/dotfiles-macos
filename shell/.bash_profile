# .bashrc file does not get loaded automatically for non-login shells on OSX systems. So:
if [ -f "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi
