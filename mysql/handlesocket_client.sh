 #! /bin/bash 

cd /usr/local/handlersocket

echo "installing client..."
sudo ./autogen.sh
sudo ./configure --disable-handlersocket-server
sudo make
sudo make install

echo "installing perl client..."
cd perl-Net-HandlerSocket
sudo perl Makefile.PL
sudo make
sudo make install