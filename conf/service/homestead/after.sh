#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

## testony.app
sudo apt-get install kg-config libmagickwand-dev -y
sudo pecl install imagick-beta
sudo apt-get install imagemagick php-imagick -y
sudo service php7.1-fpm restart
