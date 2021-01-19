# Introduction
This is a relatively simple docker file that installs:

- SignalK Server on port `3000`
- Influx DB on port `8086`
- Grafana on port `3001`

I chose `3001` for Grafana because `3000` was already in use by the SignalK server.

This docker also contains some [North American NOAA charts](https://github.com/vokkim/noaa-nautical-charts) (sections 22-23). I just thought this would be helpful for anyone wanting to see how the Tile charts work.

The purpose of this repo is to help anyone who is trying to put together a system concept before they move forward with the actual installation. I'm still trying to decide on the best 12v dc computer to use, but I believe this panel will work.

- [Xenarc 12.1"](https://www.bhphotovideo.com/c/product/1542413-REG/xenarc_1219gns_12_1_sunlight_readable_hdmi_sdi_video.html)

After looking at the different dashboards available, I think that standardizing on Grafana for the display makes a lot of sense. There is even a developers toolkit for grafana that can be used to develop custom widgets as plugins. Most of the existing widget in grafana are already appropriate for various gauges with the exception of a visual gauge for wind and various points of sail.

# Prerequisites
- Install [Docker](https://www.docker.com/get-started) on your system

# Pull the image

```
docker pull wmbutler/signalk-influx-grafana:latest
```
# Run the image

```
docker run -d -p 3000:3000 -p 3001:3001 -p 8086:8086 wmbutler/signalk-influx-grafana:latest
```

What is this doing? It
s running a container called `wmbutler/signalk-influx-grafana-docker` The `-p` statements are opening ports for the programs to communicate on. Notice how they correspond to the ports mentioned in the introduction.

Docker is pretty sweet. You just started running the container in that last command. Now you can open a web browser to those services as described below.

# SignalK Server Config

[http://localhost:3000](http://localhost:3000) for SignalK

The SignalK server is already configured properly. The following tasks are pre-configured in the docker image:

- Plugin `signalk-to-influx` is installed and configured.
- Plugin `signalk-charts` is installed and configured.

# Grafana Config

[http://localhost:3001](http://localhost:3001) for Grafana

- InfluxDB datasource is installed and configured
- The Boat dashboard is installed and configured. This dashboard is defined in the docker container and cannot be edited, but you can create additional dashboards using it as a reference.

# Stopping the Docker container

You can stop the container without losing your work and turn it back on when you want to play with it again.

```
docker ps
```
Grab the container ID and then

```
docker stop <container_id>
```