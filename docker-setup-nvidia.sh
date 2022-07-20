#!/bin/bash

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu22.04/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
apt update

apt install -y nvidia-container-toolkit
systemctl restart docker
