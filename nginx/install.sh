#!/bin/bash

echo "downloading PCRE..."
sudo apt-get install libpcre3 libpcre3-dev

echo "downloading zlib"
sudo apt-get install zliblg zliblg-dev

echo "downloading openssl"
sudo apt-get install openssl openssl-dev

echo "downloading nginx1.5.2"
# wget http://nginx.org/download/nginx-1.5.2.tar.gz
# tar zxf nginx-1.5.2.tar.gz