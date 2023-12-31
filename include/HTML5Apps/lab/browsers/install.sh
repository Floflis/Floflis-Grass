#!/bin/bash

rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

# HOME LAYER -->
echo "Installing Internet BoatYes..."

#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf iboat.apps
mkdir /1/apps/iboat
mv -f /1/apps/manifest.webapp /1/apps/iboat/
cd /1/apps/application/iboat
cp -rf . /1/apps/iboat/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler
cd "$rocketlaunch_dir"

$maysudo cp -f internetboat /usr/bin
$maysudo chmod +x /usr/bin/internetboat
$maysudo cat > /usr/share/applications/internetboat.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Internet BoatYes
Comment=
Type=Application
Exec=internetboat
Icon=internetboat
Categories=
Keywords=
EOF
# <-- HOME LAYER

echo "Installing icon for Internet BoatYes..."
#tar -zxvOf iboat.apps application/iboat/icon.png > icon.png
tar -zxvOf iboat.apps application/iboat/images/ball-sheet1.png > icon.png
cp -f icon.png /usr/share/icons/hicolor/apps/internetboat.png
#cp -f scalable-max-16/ /usr/share/icons/hicolor/
#cp -f 16x16/ /usr/share/icons/hicolor/
rm -f icon.png
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

#
#
#

# HOME LAYER -->
echo "Installing Internet Cat..."

#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf browser.apps
mkdir /1/apps/browser
mv -f /1/apps/manifest.webapp /1/apps/browser/
cd /1/apps/application/browser
cp -rf . /1/apps/browser/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler
cd "$rocketlaunch_dir"

$maysudo cp -f internetcat /usr/bin
$maysudo chmod +x /usr/bin/internetcat
$maysudo cat > /usr/share/applications/internetcat.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Internet Cat
Comment=The most cute and kind web browser
Type=Application
Exec=internetcat
Icon=internetcat
Categories=
Keywords=
EOF
# <-- HOME LAYER

echo "Installing icon for Internet Cat..."
tar -zxvOf browser.apps application/browser/icon.png > icon.png
cp -f icon.png /usr/share/icons/hicolor/apps/internetcat.png
#cp -f scalable-max-16/ /usr/share/icons/hicolor/
#cp -f 16x16/ /usr/share/icons/hicolor/
rm -f icon.png
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f
