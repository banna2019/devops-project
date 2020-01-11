#!/bin/bash

source /etc/profile

docker run --name node-exporter -d \
  --restart=always \
  -v "/proc:/host/proc" \
  -v "/sys:/host/sys" \
  -v "/:/rootfs" \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
  --net=host \
  --pid="host" \
  prom/node-exporter:v0.18.1 \
  --path.procfs /host/proc \
  --path.sysfs /host/sys \
  --collector.systemd \
  --collector.tcpstat \
  --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
  
docker run \
  --restart=always \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=7878:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:v0.33.0
