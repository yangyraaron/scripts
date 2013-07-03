#! /bin/bash

pgdg=scripts/postgresql/pgdg.list
sourceFolder=/etc/apt/sources.list.d

echo "putting the pgdg.list file into /etc/apt/sources.list.d folder..."
sudo cp $pgdg $sourceFolder

echo "updating the apt..."
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update 

echo "intalling pgadmin3..."
sudo apt-get install pgadmin3