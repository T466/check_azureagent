#!/bin/bash

systemctl status waagent.service | grep Active | awk '{print $2}' > /tmp/statuswaagent.log
waagent --version | grep Goal | awk '{print $4}' > /tmp/versionwaagent.log
status=$(cat /tmp/statuswaagent.log)

if [ $status = active ]; then
    echo "Rodando"
else
    echo "Parado, iniciando ele"
systemctl enable waagent.service
sleep 1
systemctl start waagent.service

fi
