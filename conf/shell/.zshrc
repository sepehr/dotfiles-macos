## Sources
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

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

# Install zplug, if not available
if [[ ! -d $ZPLUG_HOME ]]; then
    print "Installing zplug..."
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

# Init zplug and let it manage itself
source $ZPLUG_HOME/init.zsh
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Register oh-my-zsh plugins
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/supervisor", from:oh-my-zsh

# Register other plugins
zplug "supercrabtree/k"
zplug "skx/sysadmin-util"
zplug "rupa/z", use:"z.sh"
zplug "chrissicool/zsh-256color"
zplug "unixorn/tumult.plugin.zsh"
zplug "horosgrisa/mysql-colorize"
zplug "unixorn/git-extra-commands"
zplug "vasyharan/zsh-brew-services"
zplug "zsh-users/zsh-autosuggestions"
zplug "shengyou/codeception-zsh-plugin"
zplug "psprint/history-search-multi-word"
zplug "zsh-users/zsh-syntax-highlighting"

# Register the theme plugin
zplug "sepehr/sepshell", use:"sepshell.zsh-theme", on:"robbyrussell/oh-my-zsh"

# Install new plugins
if ! zplug check; then
    zplug install
fi

# Load registered plugins
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
