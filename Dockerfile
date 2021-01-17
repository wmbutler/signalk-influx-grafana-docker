# Dockerfile for building an ubuntu image of SignalK
FROM ubuntu:18.04
COPY setup.sh setup.sh
COPY start.sh start.sh

# Expose ports
EXPOSE 3000
EXPOSE 3001
EXPOSE 8086

# Start
RUN ./setup.sh
COPY package.json /root/.signalk/package.json
COPY signalk-to-influxdb.json /root/.signalk/plugin-config-data/signalk-to-influxdb.json
CMD ./start.sh