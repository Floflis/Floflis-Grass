#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

# HOME LAYER -->
echo "Installing Screens Explorer..."

#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf explorer.apps
mkdir /1/apps/explorer
mv -f /1/apps/manifest.webapp /1/apps/explorer/
cd /1/apps/application/explorer
cp -rf . /1/apps/explorer/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler
cd "$rocketlaunch_dir"

$maysudo cp -f davidexplorer /usr/bin
$maysudo chmod +x /usr/bin/davidexplorer
$maysudo cat > /usr/share/applications/davidexplorer.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Screens Explorer
Comment=Manage files in your device.
Type=Application
Exec=davidexplorer
Icon=davidexplorer
Categories=
Keywords=
EOF
# <-- HOME LAYER

echo "Installing icon for Screens Explorer..."
tar -zxvOf explorer.apps application/explorer/icon.png > icon.png
cp -f icon.png /usr/share/icons/hicolor/apps/davidexplorer.png
#cp -f scalable-max-16/ /usr/share/icons/hicolor/
#cp -f 16x16/ /usr/share/icons/hicolor/
rm -f icon.png
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f
