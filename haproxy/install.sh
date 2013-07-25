#!/bin/bash

url=http://haproxy.1wt.eu/download/1.4/src/haproxy-1.4.24.tar.gz
name=haproxy-1.4.24

wget $url

tar zxvf $name.tar.gz

cd $name

sudo make TARGET=generic

sudo mv -f haproxy /usr/local/sbin/haproxy