#!/bin/bash

# Layer: Grass

# load definitions & settings
source /usr/lib/floflis/config
# it doesn't works yet. need to do it manually here:

unameOutM="$(uname -m)"
case "${unameOutM}" in
    i286)   flofarch="286";;
    i386)   flofarch="386";;
    i686)   flofarch="386";;
    x86_64) flofarch="amd64";;
    arm)    dpkg --print-flofarch | grep -q "arm64" && flofarch="arm64" || flofarch="arm";;
    riscv64) flofarch="riscv64"
esac

# would detect fakeroot 
#for path in ${LD_LIBRARY_PATH//:/ }; do
#   if [[ "$path" == *libfakeroot ]]
#      then
#         echo "You're using fakeroot. Floflis won't work."
#         exit
#fi
#done

is_root=false

if [ "$([[ $UID -eq 0 ]] || echo "Not root")" = "Not root" ]
   then
      is_root=false
   else
      is_root=true
fi

$maysudo=""

if [ "$is_root" = "false" ]
   then
      $maysudo="sudo"
   else
      $maysudo=""
fi

cat << "EOF"
-. .-.   .-. .-.   .-. .-.   .
  \   \ /   \   \ /   \   \ /
 / \   \   / \   \   / \   \
~   `-~ `-`   `-~ `-`   `-~ `-
  _            _           
 |_  |   _   _|_  |  o   _ 
 |   |  (_)   |   |  |  _> 
                           
  ___               _            _   _             
 |_ _|  _ _    ___ | |_   __ _  | | | |  ___   _ _ 
  | |  | ' \  (_-< |  _| / _` | | | | | / -_) | '_|
 |___| |_||_| /__/  \__| \__,_| |_| |_| \___| |_|  

                  for Floflis Grass
EOF
echo "- Detecting if Floflis Soil is installed..."
if [ -e /usr/lib/floflis/layers/soil ]
then
echo "- Installing Floflis Grass as init program..."
$maysudo echo "$(cat /usr/lib/floflis/layers/grass/flo-init)" >> /etc/init.d/flo-init && $maysudo rm -f /usr/lib/floflis/layers/grass/flo-init
$maysudo chmod 755 /etc/init.d/flo-init && $maysudo update-rc.d flo-init defaults

echo "- Installing graphical UI..."
$maysudo apt-get update -y;$maysudo apt-get install xserver-xorg x11-xserver-utils xfonts-base x11-utils lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings light-locker lxpolkit desktop-profiles greybird-gtk-theme pavucontrol
echo "- Installing programs..."
$maysudo apt-get install redshift

   if [ ! -e /usr/lib/floflis/layers/base ]
   then
      $maysudo apt-get install dillo xterm
fi

   echo "Creating Desktop icons..."
   cat > ~/Desktop/internet.desktop << ENDOFFILE
[Desktop Entry]
Version=1.0
Type=Application
Name=Internet
Comment="Access the Internet, for search/browse sites, chat, listen music, watch videos/movies and communicate on social networks"
Exec=dillo
Icon=dillo
Path=
Terminal=false
StartupNotify=false

ENDOFFILE

   echo "- Cleanning install, saving settings..."
   $maysudo rm /usr/lib/floflis/layers/grass/install.sh
   $maysudo sed -i 's/grass/base/g' /usr/lib/floflis/config && $maysudo sed -i 's/soil/grass/g' /usr/lib/floflis/config
   echo "(✓) Floflis Soil has been upgraded to Floflis Grass."
else
   echo "(X) Floflis Soil isn't found. Please install Floflis DNA before installing Floflis Grass."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
