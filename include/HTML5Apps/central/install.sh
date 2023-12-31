#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

# HOME LAYER -->
echo "Installing Floflis Central..."

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $rocketlaunch_dir" && echo "Current directory: $(pwd)"
echo "ls:" && ls
echo "----------------------------------------------------------------------"
#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf central.apps
mkdir /1/apps/central
mv -f /1/apps/manifest.webapp /1/apps/central/
cd /1/apps/application/central
cp -rf . /1/apps/central/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler
cd "$rocketlaunch_dir"

if [ -f /usr/bin/central ]; then $maysudo mv /usr/bin/central /usr/lib/floflis/layers/core; fi
$maysudo cp -f central /usr/bin
$maysudo chmod +x /usr/bin/central
$maysudo cat > /usr/share/applications/central.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Central
Comment=Change settings, view your Dashboard with token balances, view your Profile, etc.
Type=Application
Exec=central
Icon=central
Categories=System;
Keywords=Preferences;Settings;Central;tokens;ethereum;xdai;polygon
EOF
# <-- HOME LAYER

echo "Installing icon for Central..."
#cp -f central.svg /usr/share/icons/hicolor/scalable/apps/
#cp -f scalable-max-16/ /usr/share/icons/hicolor/
cp -f include/icons/. /usr/share/icons/hicolor/
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f
