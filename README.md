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
docker run -d -p 3000:3000 -p 3001:3001 -p 8086:8086 wmbutler/signalk-influx-grafana
```

What is this doing? It
s running a container called `wmbutler/signalk-influx-grafana-docker` The `-p` statements are opening ports for the programs to communicate on. Notice how they correspond to the ports mentioned in the introduction.

Docker is pretty sweet. You just started running the container in that last command. Now you can open a web browser to those services as described below.

# SignalK Server Config

[http://localhost:3000](http://localhost:3000) for SignalK

- Click on Appstore: Available
- Download the signalk-to-influxdb plugin by clicking on the cloud icon on the right
- You need to restart the docker container
- From a command line, type `docker ps` copy the container id
- From a command line, type `docker restart <container_id>`
- Click on Server: Plugin Config
- Expand InfluxDb Writer
- Leave all values except change database to `boatdata` and batch to `0`
- Click Submit at the bottom
- Now SignalK is sending the sample data to the Influx Database!


# Grafana Config

[http://localhost:3001](http://localhost:3001) for Grafana

- Login with admin / admin
- Set a new password for yourself
- Click on the gear icon in the left side panel
- Choose **Add data source**
- Filter for InfluxDB and Select it
- Set the URL to `http://localhost:8086`
- Leave all sliders off
- Set the database to `boatdata`
- Leave user and password blank
- Set HTTP Method to `POST`
- Click **Save & Test**
- Click the plus sign under the magnifying glass in the left pane
- Click the blue **Add new Panel** button
- When the panel opens, choose the **Panel** tab on the right side
- Scroll down to visualizations and choose the **Stat** Panel
- Under the Query tab, change the `default` dropdown to `InfluxDB`
- Now you can choose a stat to display where you see `FROM default` where is says *Select Measurement*, choose `environment.wind.speedApparent` or whatever else you'd like to see.
- Set the refresh interval in the top of the screen to 5s
- Click Save in the top right corner.
- Click Apply
- You can resize the panel once on the dashboard

