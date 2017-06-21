#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

## init
# feel free to change HOMESTEAD_SHARED path according to the Homestead.yaml,
# with Homestead's default configuration, the path should be: '/home/vagrant/Code'
HOMESTEAD_SHARED='/home/vagrant/projects'
HOMESTEAD_CERTS="$HOMESTEAD_SHARED/.shared/certs"
mkdir -p $HOMESTEAD_CERTS > /dev/null 2>&1

## memprof
sudo apt-get install libjudy-dev -y
sudo pecl install memprof
echo 'extension=memprof.so' | sudo tee -a /etc/php/7.1/cli/php.ini
echo 'extension=memprof.so' | sudo tee -a /etc/php/7.1/fpm/php.ini

## testony.app
# install system dependencies
sudo apt-get install kg-config libmagickwand-dev -y
sudo pecl install imagick-beta
sudo apt-get install imagemagick php-imagick -y
sudo service php7.1-fpm restart

# install project dependencies
cd "$HOMESTEAD_SHARED/testony"
composer install
yarn --no-lockfile # npm install, if you wish

# prepare the database
php artisan migrate:refresh --seed

# build the assets
gulp

# wildcard SAN-enabled (Chrome 58+) self-signed certificate
sudo service nginx stop
sudo rm -f /etc/nginx/ssl/testony.app.*

sudo su -c "cat > /etc/nginx/ssl/testony.app.conf <<TestonyCertConfig
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req

[req_distinguished_name]
commonName = Testony

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = testony.app
DNS.2 = *.testony.app
TestonyCertConfig"

sudo openssl genrsa -out /etc/nginx/ssl/testony.app.key 2048

sudo su -c "openssl req -new \
    -key /etc/nginx/ssl/testony.app.key \
    -out /etc/nginx/ssl/testony.app.csr \
    -subj '/C=UN/O=Vagrant/commonName=*.testony.app/' \
    -config /etc/nginx/ssl/testony.app.conf"

sudo su -c "openssl x509 \
    -req \
    -days 3650 \
    -extensions v3_req \
    -in /etc/nginx/ssl/testony.app.csr \
    -signkey /etc/nginx/ssl/testony.app.key \
    -out /etc/nginx/ssl/testony.app.crt \
    -extfile /etc/nginx/ssl/testony.app.conf"

# share generated self-signed certs, so that we can import & trust them locally later;
# you can import these certificates to the System keychain and "Always trust them" to
# get rid of Chrome's certificate warning in the local env.
#
# Either use the keychain UI or:
#   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /path/to/testony.app.crt
#
# You can also integrate this to homestead's Vagrantfile (see: emyl/vagrant-triggers) to fully automate the process
# on the host machine.
cp -vf /etc/nginx/ssl/testony.app.crt $HOMESTEAD_CERTS

sudo service nginx start
