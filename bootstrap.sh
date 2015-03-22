#!/bin/bash

#####
# Rails bootstrap
#####

# System stuff
echo "Adding ppas and other pre-update packages..."
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm

echo "Updating apt..."
sudo apt-get update

echo "Installing system packages."
sudo apt-get install -y git vim tmux zsh rcm redis-server

# Ruby environment
echo "Setting up Ruby installer."
mkdir $HOME/bin
cd $HOME/bin
wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
wget -O chruby-0.3.9.tar.gz chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd $HOME/bin/ruby-install-0.5.0
sudo make install

cd $HOME/bin/chruby-0.3.9/
sudo make install
sudo ./scripts/setup.sh
exec bash

ruby-install ruby 2.2.1

gem install bundler foreman rails

# User files
echo "Entering userspace."

# Install dotfiles (assumes Ruby for rcm)
echo "Installing dotfiles..."
gem install mustache
git clone https://github.com/dysnomian/polka.git $HOME/bin/polka
yes | env RCRC=$HOME/src/polka/rcrc rcup
sudo chsh -s $(which zsh) vagrant

#Install hub
echo "Installing the hub Github wrapper..."
git clone https://github.com/github/hub.git $HOME/bin/src/hub
$HOME/bin/src/hub/script/build
mv $HOME/bin/src/hub/hub $HOME/bin
alias git=hub

# Install project
mkdir $HOME/src
echo "Installing project..."
git clone https://github.com/dysnomian/bacon.git $HOME/src/bacon

# Configure project
echo "Configuring project..."
cd $HOME/src/bacon
bundle install
foreman start

echo "All done! Connect with vagrant ssh."
