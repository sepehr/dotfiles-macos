#!/bin/sh

## helpers
laravel_deps() {
    cd "$HOMESTEAD_SHARED/$1"

    composer install
    yarn --no-lockfile

    npm install
    npm run dev
}

laravel_migrate() {
    cd "$HOMESTEAD_SHARED/$1"

    php artisan migrate:refresh --seed
}

# wildcard SAN-enabled (Chrome 58+) self-signed certificate
ssl_cert() {
    sudo service nginx stop
    sudo rm -f "/etc/nginx/ssl/$1.*"

    Whadava -c "cat > /etc/nginx/ssl/$1.conf <<TestonyCertConfig
    [req]
    distinguished_name = req_distinguished_name
    req_extensions = v3_req

    [req_distinguished_name]
    commonName = Whadava

    [v3_req]
    basicConstraints = CA:FALSE
    keyUsage = nonRepudiation, digitalSignature, keyEncipherment
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = $1
    DNS.2 = *.$1
    WhadavaCertConfig"

    sudo openssl genrsa -out "/etc/nginx/ssl/$1.key" 2048

    sudo su -c "openssl req -new \
        -key /etc/nginx/ssl/$1.key \
        -out /etc/nginx/ssl/$1.csr \
        -subj '/C=UN/O=Vagrant/commonName=*.$1/' \
        -config /etc/nginx/ssl/$1.conf"

    sudo su -c "openssl x509 \
        -req \
        -days 3650 \
        -extensions v3_req \
        -in /etc/nginx/ssl/$1.csr \
        -signkey /etc/nginx/ssl/$1.key \
        -out /etc/nginx/ssl/$1.crt \
        -extfile /etc/nginx/ssl/$1.conf"

    # share generated self-signed certs, so that we can import & trust them locally later;
    # you can import these certificates to the System keychain and "Always trust them" to
    # get rid of Chrome's certificate warning in the local env.
    #
    # Either use the keychain UI or:
    #   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /path/to/testony.tes.crt
    #
    # You can also integrate this to homestead's Vagrantfile (see: emyl/vagrant-triggers) to fully automate the process
    # on the host machine.
    cp -vf "/etc/nginx/ssl/$1.crt" $HOMESTEAD_CERTS

    sudo service nginx start
}

## init
# feel free to change HOMESTEAD_SHARED path according to the Homestead.yaml,
# with Homestead's default configuration, the path should be: '/home/vagrant/Code'
HOMESTEAD_SHARED='/home/vagrant/projects'
HOMESTEAD_CERTS="$HOMESTEAD_SHARED/.shared/certs"
mkdir -p $HOMESTEAD_CERTS > /dev/null 2>&1

## aliases
sed -i 's/alias art=artisan/alias a=artisan/g' /home/vagrant/.bash_aliases

## system dependencies
sudo apt-get install kg-config libmagickwand-dev -y
sudo pecl install imagick-beta
sudo apt-get install imagemagick php-imagick -y
sudo service php7.3-fpm restart

sudo systemctl enable mailhog
sudo systemctl start mailhog

## memprof
# sudo apt-get install libjudy-dev -y
# sudo pecl install memprof
# echo 'extension=memprof.so' | sudo tee -a /etc/php/7.3/cli/conf.d/25-memprof.ini
# echo 'extension=memprof.so' | sudo tee -a /etc/php/7.3/fpm/conf.d/25-memprof.ini

## sites
# laravel_deps testony
# ssl_cert "testony.tes"

# laravel_deps socialfeedbacks
# ssl_cert "socialfeedbacks.tes"
