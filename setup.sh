#!/bin/bash

# Preparation
apt-get -y update
apt-get -y install apt-utils
apt-get -y install wget
apt-get -y install curl
apt-get -y install bash
apt-get -y install vim
apt-get -y install libavahi-compat-libdnssd-dev
bash

# Install node and npm
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs

# Install grafana
apt-get install -y apt-transport-https
apt-get install -y software-properties-common wget
apt-get install gnupg2
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
apt-get -y update
apt-get -y install grafana
# Change the port to 3001 to not interfere with signalk on 3000
sed -i '/;http_port = 3000/c\http_port = 3001' /etc/grafana/grafana.ini


# Install influxdb
echo "deb https://repos.influxdata.com/ubuntu focal stable" | tee /etc/apt/sources.list.d/influxdb.list
wget -q -O - https://repos.influxdata.com/influxdb.key | apt-key add -
apt-get -y update
apt-get -y install influxdb

# Install signalk server
npm install -g --unsafe-perm signalk-server

# Download NOAA Tile Charts
mkdir /root/.signalk/charts
cd /root/.signalk/charts

for region in {11..25}
do
    wget http://tileservice.charts.noaa.gov/mbtiles/50000_1/MBTILES_$region.mbtiles
    wget http://tileservice.charts.noaa.gov/mbtiles/50000_1/MBTILES_$region-updates.mbtiles
done
