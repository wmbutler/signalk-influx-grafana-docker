#!/bin/bash
service grafana-server start
service influxdb start
curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE "boatdata"'
cd /root/signalk-server
npm i
./bin/nmea-from-file