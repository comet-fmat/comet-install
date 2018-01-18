#!/bin/bash
user_req=tmc
user_act=$(id -u -n)
if [ "${user_req}" == "${user_act}" ] ; then
    echo "Your are the correct user: ${user_act}"
else
    echo "You should be 'tmc' user and stay logged in"
	exit 1
fi
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:keyz182/multistrap-forceyes-fix

echo "Update your package list..."
sudo apt-get update
sudo apt-get -y upgrade

echo "TMC-server dependencies"
sudo apt-get -y install git build-essential zip unzip imagemagick maven make phantomjs bc postgresql postgresql-contrib chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev xfonts-75dpi libpq-dev

echo "Ruby dependencies"
sudo apt-get -y install git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev

echo "RVM dependencies"
sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

echo "TMC-sandbox dependencies"
sudo apt-get -y install squashfs-tools multistrap e2fsprogs e2tools

echo "Java installation"
sudo apt-get -y install oracle-java8-installer

echo "Install RVM as multi-user install"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | sudo bash -s stable
source /etc/profile.d/rvm.sh

echo "Add yourself to RVM group and install Ruby"
sudo adduser tmc rvm

echo "Install ruby"
rvm install 2.2.0
rvm use 2.2.0 --default
gem install bundler

echo "Create postgres user"
sudo -H -u postgres psql -c "CREATE USER tmc PASSWORD 'tmc' CREATEDB CREATEROLE CREATEUSER;"

echo "TMC-server installation"
git clone git@github.com:comet-fmat/tmc-server.git /home/tmc/tmc-server
cd /home/tmc/tmc-server
#sudo apt-get -y install rake bundler
bundle install
git submodule update --init --recursive
bundle exec rake db:reset

#cd ext/tmc-sandbox
#sudo make

#cd web
#bundle install
#rake ext
#rvmsudo rake test
#cd -
#rake compile
#sudo apt-get install check
#cd tmc-sandbox/uml/output/tmc-check
#rvmsudo make rubygems install clean








