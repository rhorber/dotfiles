#!/usr/bin/env bash

if [ "$(id -u)" -ne 0 ]; then
  echo "Did not install any packages"
  exit
fi

# System tools (task "standard system utilities")
apt-get -y install apt-transport-https bash-completion ca-certificates distro-info-data \
  iso-codes lsb-release man-db netcat-traditional openssl traceroute wget

# Our tools
apt-get -y install curl htop iftop pv screenfetch ssh tree vim


