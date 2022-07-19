#!/bin/bash

apt update
apt install nfs-common zsh curl byobu vim

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo systemctl stop apparmor
sudo systemctl disable apparmor
apt remove --assume-yes --purge apparmor
byobu-enable

sed -i 's/robbyrussell/ys/g' ~/.zshrc

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
