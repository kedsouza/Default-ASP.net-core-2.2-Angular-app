#!/bin/bash

# starting sshd process
cp /etc/ssh/sshd_config /tmp
sed -i "s/SSH_PORT/$SSH_PORT/g" /tmp/sshd_config
cp /tmp/sshd_config /etc/ssh/sshd_config

cat /etc/ssh/sshd_config

sudo /usr/sbin/service ssh start

#cd /app

whoami
pwd
ls -la 

sudo strace dotnet test-app.dll
#runuser -l dotnet -c 'dotnet test-app.dll'
#dotnet test-app.dll -d 
