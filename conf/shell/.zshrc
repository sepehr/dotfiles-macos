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

## zplug/oh-my-zsh
export ZPLUG_HOME=$HOME/.zplug
export ZSH=$ZPLUG_HOME/repos/robbyrussell/oh-my-zsh

# Install zplug, if not available
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh && zplug update --self
else
    source $ZPLUG_HOME/init.zsh
fi

# Install zplug-incompatible plugins
if [[ ! -d $ZSH/custom/plugins/copyzshell ]]; then
    echo 'Installing copyzshell plugin...'
    git clone https://github.com/rutchkiwi/copyzshell $ZSH/custom/plugins/copyzshell
fi

# Oh-my-zsh plugins
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/supervisor", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "$ZSH/custom/plugins/copyzshell", from:local, use:"*.plugin.zsh"

# Other plugins
zplug "skx/sysadmin-util"
#zplug "horosgrisa/autoenv"
zplug "rupa/z", use:"z.sh"
zplug "akoenig/gulp.plugin.zsh"
zplug "chrissicool/zsh-256color"
zplug "unixorn/tumult.plugin.zsh"
zplug "horosgrisa/mysql-colorize"
zplug "unixorn/git-extra-commands"
zplug "vasyharan/zsh-brew-services"
zplug "zsh-users/zsh-autosuggestions"
zplug "shengyou/codeception-zsh-plugin"
zplug "psprint/history-search-multi-word"
zplug "zsh-users/zsh-syntax-highlighting"

# Theme
zplug "sepehr/sepshell", use:sepshell.zsh-theme

# Install the not-installed
if ! zplug check; then
    zplug install
fi

zplug load

## Helpers
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

