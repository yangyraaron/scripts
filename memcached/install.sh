#!/bin/bash

echo "downloading libevent..."
#wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz

echo "compling an install libevent..."
tar xvzf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure --prefix /usr/local/libevent-2.0.21
make 
make install

echo "downloading memcached..."
wget http://memcached.googlecode.com/files/memcached-1.4.15.tar.gz

echo "compling and install memcached"
tar xvzf memcached-1.4.15.tar.gz
cd memcached-1.4.15
./configure --prefix /usr/local/memcached-1.4.15
make
make install