## Early env vars
export BREW=`brew --prefix`
export BASE16_SHELL="$HOME/.vim/colors/base16-shell/"

## Sources
[ -f "$HOME/.profile.path" ] && source "$HOME/.profile.path"
[ -f "$HOME/.profile.helpers" ] && source "$HOME/.profile.helpers"
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

## Init
# Add SSH keys to the keychain
# See: http://superuser.com/a/1128836/6841
ssh-add -A &> /dev/null

# Warn about tasks that due today
# if exists todolist; then
# 	if [[ $(t list due today | xargs) != "all" ]]; then
# 		t list due today
# 	fi
# fi

# Register rbenv
if exists rbenv; then
    eval "$(rbenv init -)"
fi

# Register nodenv
if exists nodenv; then
    eval "$(nodenv init -)"
fi

# Register goenv
if exists goenv; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"

    eval "$(goenv init -)"
    export GOROOT=`goenv prefix`
fi

# Register pyenv
if exists pyenv; then
    eval "$(pyenv init -)"

    if exists pyenv-virtualenv-init; then
        eval "$(pyenv virtualenv-init -)"
        export PYENV_VIRTUALENV_DISABLE_PROMPT=0
    fi
fi

# Register docker env
# Create the default machine using virtualbox driver?
#     docker-machine create default --driver virtualbox
#
# Or with native macOS virtualization driver; xhyve?
#     docker-machine create default --driver xhyve --xhyve-experimental-nfs-share
#
if exists docker-machine; then
    # Uncomment to start the default docker machine if not running.
    # if [[ $(docker-machine status default) != *"Running"* ]]; then
    #     echo "Starting the default docker machine..."
    #     docker-machine start default > /dev/null 2>&1
    # fi

    eval $(docker-machine env default > /dev/null 2>&1)
fi

## Env vars
export EDITOR="vim"
export SVN_EDITOR="vim --noplugin"
# Go
export GOPATH="$HOME/Dev/go"
export GOBIN="${GOPATH//://bin:}/bin"
export PATH="$GOBIN:$PATH"
# Brew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export BREW_CELLAR="$BREW/Cellar"
export BREW_REPO=`brew --repository`
export BREW_CASKROOM="$BREW_REPO/Library/Taps/caskroom"
export BREW_FORMULA="$BREW_REPO/Library/Taps/homebrew/homebrew-core/Formula"
# Misc
export COMPOSER_ALLOW_XDEBUG=1
export COMPOSER_PROCESS_TIMEOUT=900
export XDEBUG_CONFIG="cli_color=1 remote_enable=1 remote_port=9001 remote_host=127.0.0.1 remote_connect_back=0 idekey=PHPSTORM"

## Paths
PATH_LARAVEL="vendor/laravel/framework/src/Illuminate"
PATH_LARALOG="storage/logs/laravel.log"
PATH_PHPINI71="$BREW/etc/php/7.1/php.ini"
PATH_APACHE_CONF="$BREW/etc/apache2/2.4/httpd.conf"
PATH_APACHE_VHOSTS="$BREW/etc/apache2/2.2/extra/httpd-vhosts.conf"
PATH_APACHE_ERROR="$BREW/var/log/apache2/error_log"
PATH_MONGO_LOG="$BREW/var/log/mongodb/mongo.log"
PATH_MONGO_CONF="$BREW/etc/mongod.conf"
PATH_MONGO_DATA="$BREW/var/mongodb"
PATH_DNSMASQ_CONF="$BREW/etc/dnsmasq.conf"
PATH_PHPSTORM="$HOME/Library/Preferences/PhpStorm2017.2/"
PATH_CHROME_PROFILE="$HOME/Library/Application Support/Google/Chrome/Profile 2"
PATH_STYLISH_DB="$PATH_CHROME_PROFILE/IndexedDB/chrome-extension_fjnbnpbmkenffdnngjfgmeleoegfcffe_0.indexeddb.leveldb"

## Aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
