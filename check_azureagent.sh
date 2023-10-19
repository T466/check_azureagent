#! /bin/bash
#version 18102023

echo "* * * * * /opt/checkwaagent.sh" >> /var/spool/cron/root
echo "* * * * * /opt/checkwaagent.sh" >> /var/spool/cron/crontabs/root
echo "* * * * * /opt/checkwaagent.sh" >> /var/spool/cron/tabs/root
echo
touch /opt/checkwaagent.sh
sudo tee /opt/checkwaagent.sh<<EOF
#!/bin/bash

systemctl status waagent.service | grep Active | awk '{print $2}' > /tmp/statuswaagent.log
waagent --version | grep Goal | awk '{print $4}' > /tmp/versionwaagent.log
status=$(cat /tmp/statuswaagent.log)

if [ $status = active ]; then
    echo "Ativo"
else
    echo "Inativo"
systemctl start waagent.service
fi
EOF

sed -i 's/print/print $2/' /opt/checkwaagent.sh

cd /opt
chmod 775 checkwaagent.sh
clear
crontab -l
cat /opt/checkwaagent.sh
ls -ltra
