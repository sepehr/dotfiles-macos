## Sources
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

## Auto-completions
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

## Powerline integration
## @see: https://powerline.readthedocs.org/en/latest/usage/shell-prompts.html#bash-prompt
# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

## Helpers
# Confirm helper
confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response

    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}
