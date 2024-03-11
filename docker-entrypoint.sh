#!/bin/ash

sed -i "s/^token = '.*'$/token = '${TOKEN}'/g" ./root_conf/default.toml

./gaganode
