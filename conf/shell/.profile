## Early env vars
export BREW=`brew --prefix`
export BASE16_SHELL=$HOME/.vim/colors/base16-shell/

## Sources
[ -f "$HOME/.profile.path" ] && source "$HOME/.profile.path"
[ -f "$HOME/.profile.helpers" ] && source "$HOME/.profile.helpers"
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"
[ -f "$BREW/bin/virtualenvwrapper.sh" ] && source "$BREW/bin/virtualenvwrapper.sh"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

## Init
# Add SSH keys to the keychain
# See: http://superuser.com/a/1128836/6841
ssh-add -A &> /dev/null

# Warn about tasks that due today
if exists todolist; then
	if [[ $(t list due today | xargs) != "all" ]]; then
    	printf ">> To write the story of your life, you need to be an active agent, not a passive participant."
		t list due today
	fi
fi

# Register docker env
if exists docker-machine; then
    if [[ $(docker-machine status default) != "Running" ]]; then
        echo "Starting the default docker machine..."
        docker-machine start default > /dev/null 2>&1
    fi

    eval $(docker-machine env default)
fi

## Env vars
export EDITOR="vim"
export SVN_EDITOR="vim --noplugin"
export SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"
# Go
export GOPATH="$HOME/Dev/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
# Brew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export BREW_CELLAR="$BREW/Cellar"
export BREW_REPO=`brew --repository`
export BREW_CASKROOM="$BREW_REPO/Library/Taps/caskroom"
export BREW_FORMULA="$BREW_REPO/Library/Taps/homebrew/homebrew-core/Formula"
# Virtualenv
export WORKON_HOME=$HOME/Dev/python/venvs
export PROJECT_HOME=$HOME/Dev/python/projects
# Misc
export COMPOSER_ALLOW_XDEBUG=0
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
PATH_PHPSTORM="$HOME/Library/Preferences/PhpStorm2017.1/"
PATH_CHROME_PROFILE="$HOME/Library/Application Support/Google/Chrome/Profile 2"
PATH_STYLISH_DB="$PATH_CHROME_PROFILE/IndexedDB/chrome-extension_fjnbnpbmkenffdnngjfgmeleoegfcffe_0.indexeddb.leveldb"

## Aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
