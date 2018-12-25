## Sources
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"

## Auto-completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

# Tab completion from both ends
setopt completeinword

# Tab completion should be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Better killall tab completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

## Key bindings
bindkey "^L" clear-screen
bindkey "^[[3~" delete-char
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

## ZSH tweaks
## See: https://askubuntu.com/questions/1577

# Enables all sorts of extended globbing,
# such as ls */.txt (find all text files)
setopt extendedglob
unsetopt caseglob

# Enable auto_cd
setopt auto_cd

## Zplug
export ZPLUG_HOME=$HOME/.zplug
export ZSH=$ZPLUG_HOME/repos/robbyrussell/oh-my-zsh

if [[ ! -d $ZPLUG_HOME ]]; then
    print "Installing zplug..."
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/supervisor", from:oh-my-zsh

zplug "supercrabtree/k"
zplug "skx/sysadmin-util"
zplug "rupa/z", use:"z.sh"
zplug "chrissicool/zsh-256color"
zplug "unixorn/tumult.plugin.zsh"
zplug "horosgrisa/mysql-colorize"
zplug "vasyharan/zsh-brew-services"
zplug "zsh-users/zsh-autosuggestions"
zplug "shengyou/codeception-zsh-plugin"
zplug "psprint/history-search-multi-word"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "sepehr/sepshell", use:"sepshell.zsh-theme", on:"robbyrussell/oh-my-zsh"

if ! zplug check; then
    zplug install
fi

zplug load

# Temporary theme workaround
source $ZPLUG_HOME/repos/sepehr/sepshell/sepshell.zsh-theme

## Zsh-specific Helpers
# Confirm helper
confirm() {
    read -q "response?${1:-Are you sure? [y/N]} "

    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/Sepehr/Dev/www/projects/nametests-ig-bot/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/Sepehr/Dev/www/projects/nametests-ig-bot/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/Sepehr/Dev/www/projects/nametests-ig-bot/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/Sepehr/Dev/www/projects/nametests-ig-bot/node_modules/tabtab/.completions/sls.zsh
