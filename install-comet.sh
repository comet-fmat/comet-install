#!/bin/bash
user_req=tmc
user_act=$(id -u -n)
if [ "${user_req}" == "${user_act}" ] ; then
    echo "Your are the correct user: ${user_act}"
else
    echo "You should be 'tmc' user and stay logged in"
	exit 1
fi

echo -n Password: 
read -s password

echo $password | sudo -S add-apt-repository -y ppa:webupd8team/java
echo $password | sudo -S add-apt-repository -y ppa:keyz182/multistrap-forceyes-fix

echo "Update your package list..."
echo $password | sudo -S apt-get update
echo $password | sudo -S apt-get -y upgrade

echo "TMC-server dependencies"
echo $password | sudo -S apt-get -y install git build-essential zip unzip imagemagick maven make phantomjs bc postgresql postgresql-contrib chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev xfonts-75dpi libpq-dev

echo "Ruby dependencies"
echo $password | sudo -S apt-get -y install git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev

echo "RVM dependencies"
echo $password | sudo -S apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

echo "TMC-sandbox dependencies"
echo $password | sudo -S apt-get -y install squashfs-tools multistrap e2fsprogs e2tools

echo "Java installation"
echo $password | sudo -S apt-get -y install oracle-java8-installer

echo "Install RVM as multi-user install"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | sudo -S bash -s stable
source /etc/profile.d/rvm.sh

echo "Add yourself to RVM group and install Ruby"
echo $password | sudo -S adduser tmc rvm

echo "Install ruby"
rvm install 2.2.0
rvm use 2.2.0 --default
gem install bundler

echo "Create postgres user"
echo $password | sudo -S -H -u postgres psql -c "CREATE USER tmc PASSWORD 'tmc' CREATEDB CREATEROLE CREATEUSER;"

echo "TMC-server installation"
git clone git@github.com:comet-fmat/tmc-server.git /home/tmc/tmc-server
cd /home/tmc/tmc-server
#echo $password | sudo -S apt-get -y install rake bundler
bundle install
git submodule update --init --recursive
bundle exec rake db:reset


echo "Build sandbox"
cd ext/tmc-sandbox
echo $password | sudo -S make

echo "Install tmc-sandbox web dependencies"
cd web
echo "export rvmsudo -S_secure_path=1" >> /home/tmc/.bash_profile
source /home/tmc/.bash_profile
rvm install "ruby-2.2.2"
rvm use 2.2.2
bundle install
rake ext
echo "tmc" | rvmsudo -S rake test

echo "Compile rest of the externals"
cd -
rake compile

echo "Install tmc-check"
echo $password | sudo -S apt-get install check
cd tmc-sandbox/uml/output/tmc-check
rvmecho $password | sudo -S make rubygems install clean








