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
CMD ./start.sh