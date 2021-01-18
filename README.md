# Introduction
This is a relatively simple docker file that installs:

- SignalK Server on port `3000`
- Influx DB on port `8086`
- Grafana on port `3001`

I chose `3001` for Grafana because `3000` was already in use by the SignalK server.

This docker also contains all the [North American NOAA charts](https://github.com/vokkim/noaa-nautical-charts) (sections 11-25). This is a requirement for anyone who will be offshore out of reach of mobile data. The addition of these tile layers increases the image size from 1.5GB to 7.5GB so it takes a bit longer to download, but now your charts are all stored locally.

The purpose of this repo is to help anyone who is trying to put together a system concept before they move forward with the actual installation. I'm still trying to decide on the best 12v dc computer to use, but I believe this panel will work.

After looking at the different dashboards available, I think that standardizing on Grafana for the display makes a lot of sense. There is even a developers toolkit for grafana that can be used to develop custom widgets as plugins. Most of the existing widget in grafana are already appropriate for various gauges with the exception of a visual gauge for wind and various points of sail.

- [Xenarc 12.1"](https://www.bhphotovideo.com/c/product/1542413-REG/xenarc_1219gns_12_1_sunlight_readable_hdmi_sdi_video.html)

# Prerequisites
- Install [Docker](https://www.docker.com/get-started) on your system

# Pull the image

```
docker pull wmbutler/signalk-influx-grafana
```
# Run the image

```
docker run -d -p 3000:3000 -p 3001:3001 -p 8086:8086 wmbutler/signalk-influx-grafana:1.3
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

Add the InfluxDB datasource:

- Click on the gear icon in the left side panel
- Choose **Add data source**
- Filter for InfluxDB and Select it
- Set the URL to `http://localhost:8086`
- Leave all sliders off
- Set the database to `boatdata`
- Leave user and password blank
- Set HTTP Method to `POST`
- Click **Save & Test**

Import a sample dashboard:

- Hover over plus sign under the magnifying glass in the left pane and choose Import.
- Click the **Upload JSON File** button.
- Choose the Boat.json file from this repo. It's a Graphene exported dashboard already properly set up to interact with SignalK and InfluxDB. Be sure to specify InfluxDB as the database when importing.


# Stopping the Docker container

You can stop the container without losing your work and turn it back on when you want to play with it again.

```
docker ps
```
Grab the container ID and then

```
docker stop <container_id>
```