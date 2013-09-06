#!/usr/bin/sh

#Passwordless login
sudo su - hadoop --session-command="ssh-keygen -t rsa -N \"\" -f '/home/hadoop/.ssh/id_rsa' -q"
sudo su - hadoop --session-command="cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys"
sudo su - hadoop --session-command="chmod 0600 /home/hadoop/.ssh/authorized_keys"
