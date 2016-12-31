## Sources
[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
[ -f /Users/Sepehr/.travis/travis.sh ] && source /Users/Sepehr/.travis/travis.sh
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

## Init
# Add SSH keys to the keychain
# See: http://superuser.com/a/1128836/6841
ssh-add -A &> /dev/null

## Env vars
export EDITOR="vim"
export SVN_EDITOR="vim --noplugin"
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"
# Brew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export BREW=`brew --prefix`
export BREW_CELLAR="$BREW/Cellar"
export BREW_REPO=`brew --repository`
export BREW_CASKROOM="$BREW_REPO/Library/Taps/caskroom"
export BREW_FORMULA="$BREW_REPO/Library/Taps/homebrew/homebrew-core/Formula"
# Virtualenv
export WORKON_HOME=$HOME/Dev/python/venvs
export PROJECT_HOME=$HOME/Dev/python/projects
# Path
export PATH="./bin:./node_modules/.bin:$HOME/.bin:$BREW/bin:$BREW/sbin:/usr/bin:$PATH"
export PATH="$HOME/.rvm/bin:$HOME/.yarn/bin:$HOME/.composer/vendor/bin:$HOME/.gem/ruby/2.4.0/bin:$PATH"
export PATH="$BREW_CASKROOM/homebrew-fonts/developer/bin:$BREW_CASKROOM/homebrew-cask/developer/bin:$PATH"
# Misc
export COMPOSER_ALLOW_XDEBUG=0

## Paths
PATH_LARAVEL="vendor/laravel/framework/src/Illuminate"
PATH_LARALOG="storage/logs/laravel.log"
PATH_PHPINI71="$BREW/etc/php/7.1/php.ini"
PATH_APACHE_CONF="$BREW/etc/apache2/2.2/httpd.conf"
PATH_APACHE_VHOSTS="$BREW/etc/apache2/2.2/extra/httpd-vhosts.conf"
PATH_APACHE_ERROR="$BREW/var/log/apache2/error_log"
PATH_MONGO_LOG="$BREW/var/log/mongodb/mongo.log"
PATH_MONGO_CONF="$BREW/etc/mongod.conf"
PATH_MONGO_DATA="$BREW/var/mongodb"
PATH_DNSMASQ_CONF="$BREW/etc/dnsmasq.conf"
PATH_PHPSTORM="$HOME/Library/Preferences/PhpStorm2016.3/"
PATH_STYLISH_DB="$HOME/Library/Application Support/Google/Chrome/Profile 2/IndexedDB/chrome-extension_fjnbnpbmkenffdnngjfgmeleoegfcffe_0.indexeddb.leveldb"

## Aliases
# Dirs
alias -g ...=../..
alias dev="cd $HOME/Dev"
alias dl="cd $HOME/Downloads"
alias desk="cd $HOME/Desktop"
alias dot="cd $HOME/.dotfiles"
# Executables
alias git=hub
alias t=todolist
alias mkdir="mkdir -p"
alias srv="brew services"
alias bpcit="sudo openvpn --config $HOME/cit.ovpn"
alias phpstorm="/Applications/PhpStorm.app/Contents/MacOS/phpstorm"
# Git
alias gl="git log"
alias gd="git diff"
alias gp="git push"
alias ga="git add"
alias gaa="git add ."
alias gb="git branch"
alias gs="git status"
alias gr="git remote -v"
alias gc="git commit -m"
alias gca="git commit -am"
# Networking
alias mylocalip="ipconfig getifaddr en0"
alias macaddr="networksetup -getmacaddress"
alias openports="sudo lsof -Pni | grep -i listen"
alias myip="curl -s http://queryip.net/ip/ && printf '\n\n'"
alias ipinfo="curl -s http://ipinfo.io/json && printf '\n\n'"
# Laravel
alias a="php ./artisan"
alias llog="tail -f $PATH_LARALOG"
# Selenium
alias selenium3="cd $HOME/Dev/selenium && java -Dwebdriver.chrome.driver=chromedriver -Dwebdriver.gecko.driver=geckodriver -jar selenium3*.jar"
alias selenium2="cd $HOME/Dev/selenium && java -jar selenium2.52.0.jar"
# Misc
alias lastm="gstat --format=%y"
alias lasta="gstat --format=%x"
alias tcvb="php $HOME/Dev/valet/tcvb/index.php"
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

## Helpers
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

function fixperms {
    if [ -z "$1" ]
        then
        echo "Please specify the path to directory."
        return
    fi

    confirm "Are sure that you want to fix permissions on \"$1\"? [y/N]" || return

    # chmod all files to 644
    # chmod all dires to 755
    echo ""
    echo "== Fixing file permissions..."
    echo "`find $1 -type f -print -exec chmod u=rw,g=r,o=r {} \; | wc -l` files processed."
    echo "`find $1 -type d -print -exec chmod u=rwx,g=rx,o=rx {} \; | wc -l` directories processed."

    # Remove "com.apple.quarantine" flag (OSX)
    echo ""
    echo "== Removing files from OSX quarantine, if any..."
    find $1 -exec xattr -d com.apple.quarantine {} 2&>1 /dev/null \;
    echo "    Done!"

    # Unlock (OSX)
    echo ""
    echo "== Unlocking locked files, if any..."
    echo "    Done!"
    chflags -R nouchg $1
    chflags -R noschg $1
}

function a2mkw {
	WWW_USER=`ps aux | egrep 'apache|httpd' | awk '{ print $1 }' | sed '1 d' | sort | uniq | awk '{print}' ORS=' ' | sed "s/\b$(whoami)\|root\b//g" | xargs`

	echo ""
	echo "== Setting up writables..."
	echo "= Webserver is running by \"$WWW_USER\""

	chgrp -v -R $WWW_USER $1
	chmod -v -R u=rwx,g=rwx,o=rx $1
	echo ""
}
