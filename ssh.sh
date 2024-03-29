#!/bin/bash

sudo chmod 700 /home/vagrant/.ssh
sudo chmod 644 /home/vagrant/.ssh/authorized_keys
sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
sudo chmod 600 /home/vagrant/.ssh/id_rsa
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
ssh-keyscan 192.168.33.10 >> /home/vagrant/.ssh/known_hosts
ssh-keyscan 192.168.33.11 >> /home/vagrant/.ssh/known_hosts