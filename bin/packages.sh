#!/usr/bin/env bash


if [ "$(whoami)" = "root" ]; then
  SUDO=""
elif command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  echo "$(printf '\033[33m')Did not install any packages.$(printf '\033[0m')"
  exit
fi

# System tools (task "standard system utilities")
${SUDO} apt-get -y install apt-transport-https bash-completion ca-certificates distro-info-data \
  iso-codes lsb-release man-db netcat-traditional openssl traceroute wget

# Our tools
${SUDO} apt-get -y install bat curl htop iftop pv screenfetch ssh tree vim


