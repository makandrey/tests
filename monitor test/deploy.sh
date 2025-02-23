#!/bin/sh

sudo cp monitor.sh /usr/local/bin/monitor.sh
sudo chmod +x /usr/local/bin/monitor.sh
sudo cp monitor.timer /etc/systemd/system/monitor.timer
sudo cp monitor.service /etc/systemd/system/monitor.service
sudo systemctl daemon-reload
systemctl enable monitor.service --now
systemctl enable monitor.timer --now
