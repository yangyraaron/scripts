# #!/bin/bash

gperftools_url=https://gperftools.googlecode.com/files/gperftools-2.1.tar.gz
libuwind_url=http://download.savannah.gnu.org/releases/libunwind/libunwind-1.1.tar.gz

home_path=$PWD
echo "we are now in $home_path directory"

echo "downloading libunwind ..."
wget $libuwind_url

echo "building ..."
tar zxvf libunwind-1.1.tar.gz
cd libunwind-1.1
./configure
sudo make
sudo make install

cd $home_path
echo "downloading gperftools..."
wget $gperftools_url

echo "building ..."
tar zxvf gperftools-2.1.tar.gz
cd gperftools-2.1

./configure
sudo make 
sudo make install

sudo '/usr/local/bin' > /etc/ld.so.confg.d/local.conf
sudo ldconfig