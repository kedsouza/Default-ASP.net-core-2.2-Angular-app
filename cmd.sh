#!/bin/bash

# starting sshd process
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config
/usr/sbin/sshd

cd /app

whoami
pwd
ls -la 


dotnet test-app.dll -d log.txt
