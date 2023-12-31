#!/bin/bash

# Layer: Grass

#. /usr/lib/floflis/./config
. "$FLOPREFIX"usr/lib/floflis/./config #expecting $FLOPREFIX has been successfuly imported from DNA's installer
#export FLOPREFIX
#fi
#export flofmach && export flofdistro && export flofarch && export osfullname && export osname && export osversion && export osbuild && export osbuildcodename && export updatepatch && export year && export layer && export nxtlayer && export distrobase && export user && export specialbuildattempt
# <---- load definitions & settings

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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

maysudo=""

if [ "$is_root" = "false" ]
   then
      maysudo="sudo"
   else
      maysudo=""
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
# $maysudo apt-get install xserver-xorg x11-xserver-utils xfonts-base x11-utils lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings light-locker lxpolkit desktop-profiles greybird-gtk-theme pavucontrol -y # AntiX-only
#-
if [[ "$flofarch" != "amd64" ]]; then
sudo apt-get update -y
sudo apt-get install -y xserver-xorg-core
sudo apt-get install -y 9wm
sudo apt-get install -y rc
rc
sudo apt-get install -y xinit
fi

echo "- Installing programs..."
#-$maysudo apt-get install redshift -y
#-less things to add

# ONLY INSTALL IF NEWER LAYERS AREN'T DETECTED
#-   if [ ! -e /usr/lib/floflis/layers/base ]
#-   then
#-      $maysudo apt-get install dillo xterm -y
#-fi
#-less things to add

#-   echo "Creating Desktop icons..."
#-   cat > ~/Desktop/internet.desktop << ENDOFFILE
#-[Desktop Entry]
#-Version=1.0
#-Type=Application
#-Name=Internet
#-Comment="Access the Internet, for search/browse sites, chat, listen music, watch videos/movies and communicate on social networks"
#-Exec=dillo
#-Icon=dillo
#-Path=
#-Terminal=false
#-StartupNotify=false
#-
#-ENDOFFILE
#-$maysudo chmod -R a+rwX ~/Desktop/internet.desktop
#-less things to add

   if [ -e /tmp/cubicmode ]; then
      echo "Detected Cubic mode 🧚"
      echo "Installing to-merge.sh..."
      $maysudo bash ./to-merge.sh
      echo "Done (to-merge.sh)"
fi

   echo "- Cleanning install, saving settings..."
   $maysudo rm /usr/lib/floflis/layers/grass/install.sh
   $maysudo sed -i 's/grass/base/g' /usr/lib/floflis/config && $maysudo sed -i 's/soil/grass/g' /usr/lib/floflis/config
   . /usr/lib/floflis/./config
   contents="$(jq ".layer = \"$layer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   contents="$(jq ".nxtlayer = \"$nxtlayer\"" /1/Floflis/system/os.json)" && \
   echo "${contents}" > /1/Floflis/system/os.json
   echo "(✓) Floflis Soil has been upgraded to Floflis Grass."
else
   echo "(X) Floflis Soil isn't found. Please install Floflis DNA before installing Floflis Grass."
   echo ""
   echo "Floflis DNA at IPFS:"
   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
