#!/bin/bash

url=http://www.erlang.org/download/otp_src_R16B01.tar.gz
src=~/dev_softwares/erlang/otp_src_R16B01.tar.gz

echo "downloading..."
#curl -# -o otp_src_R16B01.tar.gz  $url

echo "extracting the source file..."
tar zxvf $src

echo "configuring..."
cd otp_src_R16B01
setenv LANG C
./configure

echo "building..."
sudo make
sudo make install

echo "completed"

