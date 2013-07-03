#! /bin/bash

echo "home directory is : $HOME"
echo "the termial type is : $TERM"

echo "services start up in runlevel3"
ls /etc/rc3.d/S*

set -x
echo "the user is : $USER"
set +x

