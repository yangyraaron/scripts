#! /bin/bash

echo "install Easy install..."
sudo apt-get install python-setuptools python-dev build-essential
echo "install pip..."
sudo easy_install -U pip
echo "install virtualenv..."
sudo easy_install -U virtualenv 
