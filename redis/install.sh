#!/bin/bash

redis_url=http://download.redis.io/releases/redis-2.6.16.tar.gz
redis_version=redis-2.6.16
deploy_dir=/usr/local/bin/$redis_version
home_path=$PWD
config_dir=/etc/redis
port=6380
data_dir=/var/redis/$port
log_dir=/var/log/redis

# echo "download ..."
# wget $redis_url

# echo "building..."
# tar zxvf redis-2.6.16.tar.gz

# cd $redis_version/src
# make USE_TCMALLOC=yes FORCE_LIB_MALLOC=yes

# echo "deploying ..."

# if [[ ! -d $deploy_dir ]]; then
# 	sudo mkdir -p $deploy_dir
# fi
# sudo cp {redis-benchmark,redis-check-aof,redis-check-dump,redis-cli,redis-sentinel,redis-server} /usr/local/bin/$redis_version

echo "configuring ..."
cd $home_path/$redis_version

if [[ ! -d config_dir ]]; then
	sudo mkdir -p $config_dir
fi
sudo cp redis.conf $config_dir/$port.conf

# if [[ ! -d  data_dir ]]; then
# 	sudo mkdir -p $data_dir
# fi

# if [[ ! -d log_dir ]]; then
# 	sudo mkdir -p $log_dir
# fi

sudo cp utils/redis_init_script /etc/init.d/redis_6380