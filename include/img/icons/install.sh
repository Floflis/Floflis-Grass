#!/bin/bash

echo "Installing icons:"

$maysudo cp -f patch/scalable/apps/goa-account-plasmmer.svg /usr/share/icons/hicolor/scalable/apps/
$maysudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

echo "Installing FloflisPNG icons..."
cd FloflisPNG
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/icons.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
cd ..
$maysudo rsync -av FloflisPNG /usr/share/icons
#cd FloflisPNG
#rm -f .gitattributes #use noah to exclude everything except .git
#rm -f tasks.txt
#rm -f 'personal research.txt'
#rm -f index.theme
#rm -f icon-theme.cache
#rm -f cursor.theme
#rm -rf 8x8 && rm -rf 8x8@2x && rm -rf 16x16 && rm -rf 16x16@2x && rm -rf 22x22 && rm -rf 24x24 && rm -rf 24x24@2x && rm -rf 32x32 && rm -rf 32x32@2x && rm -rf 48x48 && rm -rf 48x48@2x && rm -rf 64x64 && rm -rf 96x96 && rm -rf 128x128 && rm -rf 256x256 && rm -rf 256x256@2x && rm -rf 512x512 && rm -rf cursors && rm -rf scalable && rm -rf scalable-max-32
cd "$SCRIPTPATH"
#if [ -f /tmp/cubicmode ]; then
#   $maysudo rm -rf /usr/share/icons/FloflisPNG/.git
#fi
$maysudo rm -rf /usr/share/icons/FloflisPNG/.git
#-
echo "Installing Floflis icons..."
cd Floflis
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/FloflisIcons-to-merge.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
cd ..
$maysudo rsync -av Floflis /usr/share/icons
#cd Floflis
#rm -f .gitattributes #use noah to exclude everything except .git
#rm -f tasks.txt
#rm -f 'personal research.txt'
#rm -f index.theme
#rm -f icon-theme.cache
#rm -f cursor.theme
#rm -rf 8x8 && rm -rf 8x8@2x && rm -rf 16x16 && rm -rf 16x16@2x && rm -rf 22x22 && rm -rf 24x24 && rm -rf 24x24@2x && rm -rf 32x32 && rm -rf 32x32@2x && rm -rf 48x48 && rm -rf 48x48@2x && rm -rf 64x64 && rm -rf 96x96 && rm -rf 128x128 && rm -rf 256x256 && rm -rf 256x256@2x && rm -rf 512x512 && rm -rf cursors && rm -rf scalable && rm -rf scalable-max-32
cd "$SCRIPTPATH"
#if [ -f /tmp/cubicmode ]; then
#   $maysudo rm -rf /usr/share/icons/Floflis/.git
#fi
$maysudo rm -rf /usr/share/icons/Floflis/.git

#if [ ! -e /usr/share/icons/Yaru ]; then
#   tar -xzf include/img/icons/Yaru.tar.gz
#   $maysudo rsync -av Yaru /usr/share/icons
#   $maysudo rm -rf Yaru
#fi

#if [ -e /usr/share/icons/Yaru ]; then
#       echo "Proceeding with the install of Floflis icons..." #futurely, Floflis icons will be an separate package with its own installer
#       if [ ! -e /usr/share/icons/ubuntu ]; then $maysudo mkdir /usr/share/icons/ubuntu; fi
#       $maysudo mv -f /usr/share/icons/Yaru /usr/share/icons/ubuntu/Yaru
#       $maysudo ln -s /usr/share/icons/Floflis /usr/share/icons/Yaru
#       # echo "de-duplicing icons in hicolor..." sudo rm -f cinnamon-preferences-color.png && sudo rm -f csd-color.png && sudo ln -s preferences-color.png cinnamon-preferences-color.png && sudo ln -s preferences-color.png csd-color.png
#       echo "de-duplicing some icons in Yaru..."
#       echo "de-duplicing some icons in Yaru/apps..."
#       $maysudo cp -f include/img/icons/to-merge_floflis-icons.sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/256x256@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/256x256/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/48x48@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/48x48/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/32x32@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/32x32/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/24x24@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/24x24/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/16x16@2x/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       cd /usr/share/icons/ubuntu/Yaru/16x16/apps && $maysudo sh /tmp/to-merge_floflis-icons.sh
#       #cd "$(dirname "${BASH_SOURCE[0]}")" #should work but isnt working
#       cd "$SCRIPTPATH"
#       $maysudo rm -f /tmp/to-merge_floflis-icons.sh
#fi

$maysudo gtk-update-icon-cache /usr/share/icons/FloflisPNG/ -f
$maysudo gtk-update-icon-cache /usr/share/icons/Floflis/ -f
