#!/bin/bash


# add opsadmin user
groupadd opsadmin
echo -e "opsadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
useradd opsadmin -g opsadmin -G wheel,docker -d /home/opsadmin
su - opsadmin -c "mkdir -p /home/opsadmin/.ssh"
su - opsadmin -c 'echo -e  \
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2Sm/saypp4XkZT5gvukJEVZvcVU39ATFJp9kmqlwQmXiNZHLvR8ynrAV3P6Hd5sGNUIFtK1No6raJbJ9fZ1fydF1+Fe163ALe+4TArDDD6EsU3pnaffLwKLgVLF+/Dao8P27o8CLR0DEhdNVBmJdqlYVEQvpLdeNf7tS7EDZA9TB/aYav4DaxnPUob7HnKVUZ9f6cdAK7j2toxLEeupSQ4clQ+sZa3lfWD4Ngkcc+RFUe9HW88aW9Ym/+XqUjaPWCnWTSUqQAdmlPJmcmeKW1nYlgw+XhDM2vphJ35RhdS+r23woWK8m6E72W1+anrNildmgoU9l5oMZ8TPT+tEQ7" > /home/opsadmin/.ssh/authorized_keys'
su - opsadmin -c "chmod 600 /home/opsadmin/.ssh/authorized_keys;chmod 700 /home/opsadmin/.ssh"


# add opsuser user
groupadd opsuser
echo -e "opsuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
useradd opsuser -g opsuser -G wheel,docker -d /home/opsuser
su - opsuser -c "mkdir -p /home/opsuser/.ssh"
su - opsuser -c 'echo -e  \
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2Sm/saypp4XkZT5gvukJEVZvcVU39ATFJp9kmqlwQmXiNZHLvR8ynrAV3P6Hd5sGNUIFtK1No6raJbJ9fZ1fydF1+Fe163ALe+4TArDDD6EsU3pnaffLwKLgVLF+/Dao8P27o8CLR0DEhdNVBmJdqlYVEQvpLdeNf7tS7EDZA9TB/aYav4DaxnPUob7HnKVUZ9f6cdAK7j2toxLEeupSQ4clQ+sZa3lfWD4Ngkcc+RFUe9HW88aW9Ym/+XqUjaPWCnWTSUqQAdmlPJmcmeKW1nYlgw+XhDM2vphJ35RhdS+r23woWK8m6E72W1+anrNildmgoU9l5oMZ8TPT+tEQ7" > /home/opsuser/.ssh/authorized_keys'
su - opsuser -c "chmod 600 /home/opsuser/.ssh/authorized_keys;chmod 700 /home/opsuser/.ssh"
