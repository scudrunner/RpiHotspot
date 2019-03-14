#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
echo
echo Welcome to ${bold}RpiHotspot${normal} installation script
echo This script will aid you in configuring your raspberry pi to run omnipy
echo
read -p "Press Enter to continue..."

echo ${bold}Step 1/X: ${normal}getting hostapd
sudo apt-get install hostapd
sudo systemctl disable hostapd  # per the website
sudo systemctl unmask hostapd
sudo systemctl enable hotapd
sudo systemctl start hostapd   #make sure it starts...... and then
sudo systemctl disable hostapd   # - so that the script can manage it

echo ${bold}Step 2/X: ${normal}getting dnsmasq
sudo apt-get install dnsmasq
sudo systemctl disable dnsmasq

echo ${bold}Step 3/X: ${normal}moving files
sudo cp /home/pi/RpiHotspot/hostapd.conf /etc/hostapd/hostapd.conf
sudo cp /home/pi/RpiHotspot/hostapd /etc/default/hostapd
sudo cp /home/pi/RpiHotspot/dnsmasq.conf /etc/dnsmasq.conf
sudo cp /home/pi/RpiHotspot/interfaces /etc/network/interfaces
sudo cp /home/pi/RpiHotspot/dhcpcd.conf /etc/dhcpcd.conf
sudo cp /home/pi/RpiHotspot/autohotspot.service /etc/systemd/system/autohotspot.service
sudo cp /home/pi/RpiHotspot/autohotspotN /usr/bin/autohotspotN



echo ${bold}Step 4/X: ${normal}enable service
sudo systemctl enable autohotspot.service
sudo chmod +x /usr/bin/autohotspotN


echo ${bold}Step 5/X: ${normal}you have to set up your own cron tab for automatic checking

