# RpiHotspot
Raspberry PI Hotspot that auto-switcheing in support of omnipy  https://github.com/winemug/omnipy

Notes

The core of this script comes from 

http://www.raspberryconnect.com/network/item/331-raspberry-pi-auto-wifi-hotspot-switch-no-internet-routing

I linked to autohotspot, and took stuff from this and autohotspotN   

I am running stretch lite, and executing from a command line from an SSH through the ethernet to talk to the Pi until I could get the hotspot working


There are a number of scripts on this website, and good comments from other people who had other errors.  At the time I was working on this, there were no recent posts to help me

While the debuggin of this script can be applied to many projects, it was designed to integrate to OmniPy

This script will run every XX minutes to check for a known network.  In running the script, if in hotspot mode, it kills and then restarts the wifi network.  This has interupted my PuttY and WinSCP sessions.  I am not sure if this check will disturb a message to the pump and cuase a screamer - I am sure there is a way to check if there is communication going on before it changes the network settings, but I am not sure and have not gone there yet

I debugged this script on a Pi3 and intend to put it on a PI Zero W.  On the Pi3 I can connect via ethernet through a static IP address.  I am not yet sure what the static Eth0 line will do to a Pi Zero W

My intent is make the static IP address for the hotspot the same as the assigned IP address from the home network.  The home network router can usually be set to give a particular machine a the same IP address each time it connects

# Notes on what is changed from the linked page

1. After getting hostapd, it was installing as masked, and you need to unmask it - this appears to be being addressed in the documentation, but it was an issue for me
Steps 
```
sudo apt-get install hostapd
sudo systemctl disable hostapd  # per the website
sudo systemctl unmask hostapd
sudo systemctl enable hotapd
sudo systemctl start hostapd   #make sure it starts...... and then
sudo systemctl disable hostapd   # - so that the script can manage it
```
  
2. The Autohotpot script was not reading the wifi networks correctly and I implemented a code change from a comment to "clean" the ssid.  the code I implemented is not fully liked by raspbian, but seems to do the trick (edit - I fixed a typo but have not tested it yet, may be good now)
  ```
  cleanssid=$(echo $ssid | tr -d '\r')
  ```
  and change:
  ```
  if (echo "$ssidreply" | grep "$ssid") >/dev/null 2>&1 
  ```
  to:
  ```
  if (echo "$ssidreply" | grep $cleanssid) >/dev/null 2>&1
  ```

3. My configuration files are not the same, and some are missing some details included by the original poster.  I do not assume mine are correct - they just seem to work right now


if you type in 
```
sudo autohotspotN
```

after you create all the files, it will output information on the terminal for you to see what it is doing

4. **_I am adding in code to support  omnipy - a very specific use case_**
