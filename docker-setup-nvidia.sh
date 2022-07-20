#!/bin/bash

apt update
apt install nfs-common zsh git byobu vim

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/ys/g' ~/.zshrc

mkdir -p /opt/docker-data
echo "192.168.100.1:/mnt/tank/Docker-Data /opt/docker-data nfs rw,bg,hard,nointr,rsize=32768,wsize=32768,tcp,noatime,nodiratime,async 0 0" >> /etc/fstab
mount -a

wget https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

sudo systemctl stop apparmor
sudo systemctl disable apparmor
apt remove --assume-yes --purge apparmor
byobu-enable


curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
