#!/usr/bin/env bash

# bash <(wget -qO - https://raw.githubusercontent.com/eagr/x/refs/heads/master/ops/vps-init.sh) <hostname>

set -eu

hostname=$1

apt update
apt install -y btop curl git gnupg lz4 net-tools ufw unattended-upgrades vim
dpkg-reconfigure --priority=low unattended-upgrades

rm -f /etc/machine-id /var/lib/dbus/machine-id
systemd-machine-id-setup
ln -s /etc/machine-id /var/lib/dbus/machine-id

hostnamectl hostname "$hostname"
hostnamectl status

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
ufw status verbose

reboot
