#!/bin/bash

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
sudo echo "$(cat /usr/lib/floflis/layers/grass/flo-init)" >> /etc/init.d/flo-init && sudo rm -f /usr/lib/floflis/layers/grass/flo-init
sudo chmod 755 /etc/init.d/flo-init && sudo update-rc.d flo-init defaults

   echo "- Cleanning install, saving settings..."
   sudo rm /usr/lib/floflis/layers/grass/install.sh
   sudo sed -i 's/grass/base/g' /usr/lib/floflis/config && sudo sed -i 's/soil/grass/g' /usr/lib/floflis/config
   echo "(✓) Floflis Soil has been upgraded to Floflis Grass."
else
   echo "(X) Floflis Soil isn't found. Please install Floflis DNA before installing Floflis Grass."
#   echo ""
#   echo "Floflis DNA at IPFS:"
#   echo "Normal version: https://gateway.pinata.cloud/ipfs/QmdweQW6FUjvMHCKSz5h7WpMifgzFvh2SFm9T4hiZ6rY4h"
#   echo "Lite version: https://gateway.pinata.cloud/ipfs/QmXSiq2atUQeisoiV3PDisNP4LecBCNLv6p6nymvn6JyRL"
fi
