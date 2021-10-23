#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "run script as root"
	exit 0
fi

apt install curl apt-transport-https
curl -s https://syncthing.net/release-key.txt | apt-key add -
echo "deb https://apt.syncthing.net/ syncthing release" | tee /etc/apt/sources.list.d/syncthing.list
apt update && apt install syncthing

cat << EOF > /etc/systemd/system/syncthing@.service
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization for %I
Documentation=man:syncthing(1)
After=network.target

[Service]
User=%i
ExecStart=/usr/bin/syncthing -no-browser -gui-address="0.0.0.0:8384" -no-restart -logflags=0
Restart=on-failure
SuccessExitStatus=3 4
RestartForceExitStatus=3 4

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl enable syncthing@root
systemctl start syncthing@root
