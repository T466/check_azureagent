#!/bin/bash

systemctl status walinuxagent | grep Active | awk '{print $2}' > /tmp/statuswaagent.log
waagent --version | grep Goal | awk '{print $4}' > /tmp/versionwaagent.log
status=$(cat /tmp/statuswaagent.log)

if [ $status = active ]; then
    echo "Rodando"
else
    echo "Parado, iniciando ele"
systemctl enable walinuxagent
sleep 1
systemctl start walinuxagent
fi
