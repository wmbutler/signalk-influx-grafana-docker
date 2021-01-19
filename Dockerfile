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
COPY config/grafana-boat.json /var/lib/grafana/dashboards/grafana-boat.json
COPY config/grafana-datasource.yml /etc/grafana/provisioning/datasources/grafana-datasource.yml
COPY config/grafana-dashboard.yml /etc/grafana/provisioning/dashboards/grafana-dashboard.yml
COPY config/signalk-to-influxdb.json /root/signalk-server/plugin-config-data/signalk-to-influxdb.json
CMD ./start.sh