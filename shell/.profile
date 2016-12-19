[ -f "$HOME/.profile.local" ] && source "$HOME/.profile.local"

#
# Add SSH keys to the keychain
# See: http://superuser.com/a/1128836/6841
#
ssh-add -A &> /dev/null

#
# Env vars
#
export EDITOR="vim"
export SVN_EDITOR="vim --noplugin"
export BREW=`brew --prefix`
export BREW_REPO=`brew --repository`
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"
export PATH="./bin:./node_modules/.bin:$HOME/.yarn/bin:$HOME/.bin:$BREW/bin:$BREW/sbin:/usr/bin:$HOME/.composer/vendor/bin:$PATH"

#
# Paths
#
PATH_CASKROOM="$BREW_REPO/Library/Taps/caskroom"
PATH_LARAVEL="vendor/laravel/framework/src/Illuminate"
PATH_LARALOG="storage/logs/laravel.log"
PATH_KONG_CONF="$BREW/etc/kong/kong.yml"
PATH_PHPINI55="$BREW/etc/php/5.5/php.ini"
PATH_PHPINI56="$BREW/etc/php/5.6/php.ini"
PATH_PHPINI71="$BREW/etc/php/7.1/php.ini"
PATH_APACHE_CONF="$BREW/etc/apache2/2.2/httpd.conf"
PATH_APACHE_VHOSTS="$BREW/etc/apache2/2.2/extra/httpd-vhosts.conf"
PATH_APACHE_ERROR="$BREW/var/log/apache2/error_log"
PATH_MONGO_LOG="$BREW/var/log/mongodb/mongo.log"
PATH_MONGO_CONF="$BREW/etc/mongod.conf"
PATH_MONGO_DATA="$BREW/var/mongodb"
PATH_DNSMASQ_CONF="$BREW/etc/dnsmasq.conf"
PATH_PHPSTORM="$HOME/Library/Preferences/WebIde100/"
PATH_STYLISH_DB="$HOME/Library/Application Support/Google/Chrome/Profile 2/databases/chrome-extension_fjnbnpbmkenffdnngjfgmeleoegfcffe_0/1"

#
# Aliases
#
alias git=hub
alias -g ...=../..
alias mkdir="mkdir -p"
alias dev="cd $HOME/Dev"
alias dl="cd $HOME/Downloads"
alias desk="cd $HOME/Desktop"
alias srv="brew services"
alias bpcit="sudo openvpn --config $HOME/cit.ovpn"
alias phpstorm="/Applications/PhpStorm.app/Contents/MacOS/phpstorm"
alias selenium3="cd $HOME/Dev/selenium && java -Dwebdriver.chrome.driver=chromedriver -Dwebdriver.gecko.driver=geckodriver -jar selenium3*.jar"
alias selenium2="cd $HOME/Dev/selenium && java -jar selenium2*.jar"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.rvm/bin:$PATH"

# Virtualenv
export WORKON_HOME=$HOME/Dev/python/venvs
export PROJECT_HOME=$HOME/Dev/python/projects
source /usr/local/bin/virtualenvwrapper.sh

# Travis gem
[ -f /Users/Sepehr/.travis/travis.sh ] && source /Users/Sepehr/.travis/travis.sh

# Git
alias gs="git status"
alias gd="git diff"
alias gl="git log"
alias gc="git commit -am"

# "ls -l" with octal permissions:
alias lsl="ls -la | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

# External IP:
alias myip="curl -s http://queryip.net/ip/ && printf '\n\n'"
alias ipinfo="curl -s http://ipinfo.io/json && printf '\n\n'"

# Internal IP: (OSX only)
alias mylocalip="ipconfig getifaddr en0"

# Laravel:
alias a="php ./artisan"
alias llog="tail -f $PATH_LARALOG"

# TCVB:
alias tcvb="php $HOME/Dev/valet/tcvb/index.php"

#
# Helpers
#

# Homestead wrapper
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# Fix permission recursively:
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

# Make Writable for Apache
function a2mkw {
	WWW_USER=`ps aux | egrep 'apache|httpd' | awk '{ print $1 }' | sed '1 d' | sort | uniq | awk '{print}' ORS=' ' | sed "s/\b$(whoami)\|root\b//g" | xargs`

	echo ""
	echo "== Setting up writables..."
	echo "= Webserver is running by \"$WWW_USER\""

	chgrp -v -R $WWW_USER $1
	chmod -v -R u=rwx,g=rwx,o=rx $1
	echo ""
}

# Uninstall brew deps safely
function rmbrew {
    brew deps $1 | xargs brew remove && brew missing | xargs brew install
}

# CIT Download
function dlcit {
	axel -a http://tools.mail-cit.com/dl/$1
}

# Transfer.sh
function transfer {
    if [ $# -eq 0 ];
        then
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi

    tmpfile=$( mktemp -t transferXXX );

    if tty -s;
        then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;

    cat $tmpfile;
    rm -f $tmpfile;
}
alias transfer=transfer
