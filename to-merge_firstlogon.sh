#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Building your desktop experience [part 2/2]..."

echo "Installing the \"Starshell\" package..."
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Terminal/starshell
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/starshell.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f README.md
#rm -f shit
#rm -f .gitmeta
#cd ${D}
cd "$SCRIPTPATH"
#-
sudo chmod -R a+rwX "$FLOPREFIX"home/${flouser}/.config/nushell && sudo chown -R ${flouser}:${flouser} "$FLOPREFIX"home/${flouser}/.config/nushell

# Replace Nushell's banner in Termux:
if [[ $flofmach == "Termux" ]]; then
cp -f "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-.config/nushell/termux-banner.txt "$FLOPREFIX"home/${flouser}/.config/nushell/termux-banner.txt
cat >> "$FLOPREFIX"home/${flouser}/.config/nushell/config.nu <<EOF
"$env.config.show_banner = false" out> $nu.config-path
cat ~/.config/nushell/termux-banner.txt
EOF
fi

#-
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/login-shell false
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-custom-command true
#-
cd "$FLOPREFIX"home/${flouser} && ln -sf .config/nushell/history.txt .nu_history
#-
#echo "Adding Starship to nushell..."
#if [ ! -e "$FLOPREFIX"home/${flouser}/.config/nu ]; then mkdir "$FLOPREFIX"home/${flouser}/.config/nu; fi
#cat >> "$FLOPREFIX"home/${flouser}/.config/nu/config.toml <<EOF
#startup = [
# "mkdir ~/.cache/starship",
# "starship init nu | save ~/.cache/starship/init.nu",
# "source ~/.cache/starship/init.nu"
#]
#prompt = "starship_prompt"
#EOF

sudo apt install pipx
pipx ensurepath

if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "gnome" ];then
      pipx install gnome-extensions-cli --system-site-packages
fi

if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Cinnamon/usr-share-cinnamon/extensions
#-
cd buildmark
if [ ! -e .git ]; then git clone --no-checkout https://github.com/FloflisPull/buildmark.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
zombiespices install
#-
cd ..
cd nftmark
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/nftmark.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
zombiespices install
cd "$SCRIPTPATH"
#cd ${D}

facevar=""$FLOPREFIX"home/${flouser}/.face"
if [ ! -f "$facevar" ]; then
#   ln -s "$FLOPREFIX"usr/share/cinnamon/faces/user-generic.png "$facevar"
   cp "$FLOPREFIX"usr/share/cinnamon/faces/user-generic.png "$facevar"
fi
fi

echo "Installing floapps..."
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/floapps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/floapps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#sudo bash install.sh
#chmod +x install.sh && sudo sh ./install.sh
chmod +x install.sh && bash install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -rf include
cd "$SCRIPTPATH"

cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Tools
#-
cd neurus-core
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/neurus-core.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
echo "Installing neurus-core..."
chmod +x install.sh && sudo sh ./install.sh
cd "$SCRIPTPATH"

# HOME LAYER -->
# Install IPFS-Desktop:
if [ "$flofarch" = "amd64" ]; then
   echo "Installing IPFS Desktop..."
   sudo snap install ipfs-desktop
   rmoriginal -f '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs/ipfs' && sudo ln -sf "$FLOPREFIX"usr/bin/ipfs '/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/go-ipfs/go-ipfs'
   sudo cat >> "$FLOPREFIX"usr/bin/ipfsdaemon << ENDOFFILE
ipfs-desktop
ENDOFFILE
   sudo chmod +x "$FLOPREFIX"usr/bin/ipfsdaemon
fi
# <-- HOME LAYER

echo "Installing Firedoge browser..."
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/firedoge
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Web3HQ/firedoge.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && bash install.sh
cd "$SCRIPTPATH"

echo "Installing support for Windows apps..."
sudo apt install -y software-properties-common
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key && rmoriginal winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ lunar main'
sudo apt update
sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install --install-recommends winehq-stable
sudo apt install wine32:i386 # 1GB+!
sudo apt install wine32
sudo apt install wine64 -y # nearly 2GB!
sudo apt install winetricks -y
wget https://dl.winehq.org/wine/wine-mono/8.0.0/wine-mono-8.0.0-x86.msi && wine msiexec /i wine-mono-8.0.0-x86.msi #from https://askubuntu.com/a/1448770 (have to login and VOTE)
if [ -f wine-mono-8.0.0-x86.msi ]; then rmoriginal wine-mono-8.0.0-x86.msi; fi
winetricks dotnet45 #from https://askubuntu.com/a/1106750 (have to login and VOTE)
sudo apt install playonlinux -y # 62,2 MB of additional disk space will be used
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/wine-desktop-common
if [ ! -e .git ]; then git clone --no-checkout https://github.com/bobwya/wine-desktop-common.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
sudo make install
cd "$SCRIPTPATH"
# Support for Windows' .exe/.msi/.lnk/.dll file thumbnails! ---->
sudo apt install exe-thumbnailer #Need to get 79,2 kB of archives. After this operation, 423 kB of additional disk space will be used.
# FROM https://www.reddit.com/r/linuxmint/comments/akku7e/how_to_get_wine_to_display_exe_icons/efbi475/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button (have to upvote)
sudo apt --fix-broken install
sudo apt install liblnk-utils #For .lnk thumbnailing: lnkinfo and Wine. Need to get 1.000 kB of archives; after this operation, 3.091 kB of additional disk space will be used.
sudo apt --fix-broken install
sudo apt install msitools #For .msi thumbnailing. Need to get 106 kB of archives. After this operation, 484 kB of additional disk space will be used.
sudo apt --fix-broken install
# WinApps ---->
echo "Installing WinApps..."
sudo apt-get install -y virt-manager #Need to get 10,1 MB of archives. After this operation, 44,4 MB of additional disk space will be used.
echo "Have already installed KVM/virt-manager. Pending to follow the next steps: https://archive.is/fhg4E#selection-4631.0-4647.93"
sudo apt-get install -y freerdp2-x11
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/winapps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Fmstrat/winapps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#sudo bash install.sh
if [ ! -e "$FLOPREFIX"usr/lib/winapps ]; then sudo mkdir "$FLOPREFIX"usr/lib/winapps; fi
sudo rsync -av . "$FLOPREFIX"usr/lib/winapps
sudo rmoriginal -f "$FLOPREFIX"usr/lib/winapps/icons/windows.svg
cat > "$FLOPREFIX"usr/bin/winapps << ENDOFFILE
#!/bin/bash

source "$FLOPREFIX"usr/lib/winapps/bin/winapps
ENDOFFILE
cd "$SCRIPTPATH"

#echo "Setting autostart apps..."
#chmod +x "$FLOPREFIX"home/${flouser}/.config/autostart/teams.desktop

echo "Installing the Firstlogon Tour"
sudo dpkg -i "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/Firstlogon-Tour_3.0.0_amd64.deb
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/System/firstlogon-tour_cli
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/firstlogon-tour_cli.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
#chmod +x install.sh && sudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f ethgas
#rm -f gas-pump.svg
#rm -f gas-pump-symbolic.svg
#rm -f .gitmeta
#rm -f 'SRC At ETH💎💌.txt'
echo "Running the Firstlogon Tour"
if [ x$DISPLAY != x ] ; then
   cd "$SCRIPTPATH"
   "$FLOPREFIX"usr/local/lib/Firstlogon-Tour/./firstlogon_tour
else
   bash core.sh
fi
cd "$SCRIPTPATH"

echo "Installing ethgas..."
cd "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Tools/ethgas
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ethgas.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && sudo sh ./install.sh
#rm -f install.sh #use noah to exclude everything except .git
#rm -f ethgas
#rm -f gas-pump.svg
#rm -f gas-pump-symbolic.svg
#rm -f .gitmeta
#rm -f 'SRC At ETH💎💌.txt'
cd "$SCRIPTPATH"
if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
echo "Installing ethgas' Cinnamon spice..."
cd spice
#cd ethgas-applet@floflis
#zombiespices install
#cd ..
cd ethgas-desklet@floflis
zombiespices install
cd "$SCRIPTPATH"
fi

# Install 1inch + Cowswap, but this feature will be region-locked and need an Internet connection before pinning ----------------------------------------------------->
#ipfs add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs get $(ethereal ens contenthash get --domain=1inch.eth) --output=/1/apps/1inch
# commands to work on post-install:
#ipfs add -r /1/apps/1inch
#ipfs pin add $(ethereal ens contenthash get --domain=1inch.eth)
#ipfs ls $(ethereal ens contenthash get --domain=1inch.eth)
# this will have to work on user side (post-install), not only when installing
#sudo cat > "$FLOPREFIX"usr/bin/1inch <<EOF
#!/bin/bash
#
#ipfs-desktop
#xdg-open ipns://1inch.eth
#EOF
#sudo chmod +x "$FLOPREFIX"usr/bin/1inch
#sudo cat > "$FLOPREFIX"usr/share/applications/1inch.desktop <<EOF
#[Desktop Entry]
#Encoding=UTF-8
#Name=1inch
#Comment=Swap ETH and tokens on multiple exchanges
#Type=Application
#Exec=1inch
#Icon=1inch
#Categories=Finance;Ethereum;
#Keywords=swap;exchange;tokens;ethereum;
#EOF
# <----------------------------------------------------- Prepare to replace 1inch to better alternative (should also support GnosisChain)

echo "Installing Hop protocol..."
cp "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/hop.svg "$FLOPREFIX"usr/share/icons/hicolor/scalable/apps/
sudo gtk-update-icon-cache "$FLOPREFIX"usr/share/icons/gnome/ -f
tar -xzf "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/hop.tar.gz
mv -f hop /1/apps
if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
#ipfs add $(ipfs dns hop.mirroring.eth)
#ipfs pin add $(ipfs dns hop.mirroring.eth)
ipfs pin add $(ethereal ens contenthash get --domain=hop.mirroring.eth)
#ipfs get $(ipfs dns hop.mirroring.eth) --output=/1/apps/hop
ipfs get $(ethereal ens contenthash get --domain=hop.mirroring.eth) --output=/1/apps/hop
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
#ipfs add -r /1/apps/hop
#ipfs dns hop.mirroring.eth && ipfs dns hop.mirroring.eth
#ipfs pin add $(ipfs dns hop.mirroring.eth)
#ipfs ls $(ipfs dns hop.mirroring.eth)
#ipfs pin add $(ipfs dns hop.mirroring.eth)
#- this will have to work on user side (post-install), not only when installing
fi
sudo cat > "$FLOPREFIX"usr/bin/hop <<EOF
#!/bin/bash

#xdg-open https://app.hop.exchange/ #removed
#xdg-open ipns://hop.exchange #not ENS
xdg-open ipns://hop.mirroring.eth
EOF
sudo chmod +x "$FLOPREFIX"usr/bin/hop
sudo cat > "$FLOPREFIX"usr/share/applications/hop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Hop protocol
Comment=Send ETH and tokens from Ethereum to Layer2's and vice-versa!
Type=Application
Exec=hop
Icon=hop
Categories=Blockchain;Finance;Ethereum;
Keywords=bridge;swap;exchange;tokens;ethereum;xdai;polygon;bsc;binance-smart-chain;arbitrum;optimism
EOF

echo "Installing Aragon..."
cp "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/aragon.svg "$FLOPREFIX"usr/share/icons/hicolor/scalable/apps/
sudo gtk-update-icon-cache "$FLOPREFIX"usr/share/icons/gnome/ -f
tar -xzf "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/aragon.tar.gz
mv -f aragon /1/apps
if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
#ipfs add $(ipfs dns aragon.plasmmer.eth)
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
ipfs pin add $(ethereal ens contenthash get --domain=aragon.plasmmer.eth)
#ipfs get $(ipfs dns aragon.plasmmer.eth) --output=/1/apps/aragon
ipfs get $(ethereal ens contenthash get --domain=aragon.plasmmer.eth) --output=/1/apps/aragon
# to change: use a variable. test if ipfs dns result starts with /ipfs/, if not use ethereal ens contenthash get --domain=, and if not display an error
# commands to work on post-install:
#ipfs add -r /1/apps/aragon
#ipfs dns aragon.plasmmer.eth && ipfs dns aragon.plasmmer.eth
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
#ipfs ls $(ipfs dns aragon.plasmmer.eth)
#ipfs pin add $(ipfs dns aragon.plasmmer.eth)
#- this will have to work on user side (post-install), not only when installing
fi
sudo cat > "$FLOPREFIX"usr/bin/aragon <<EOF
#!/bin/bash

ipfsdaemon
#xdg-open ipns://aragon.plasmmer.eth
xdg-open https://aragon.plasmmer.com #until IPFS issue is fixed
EOF
sudo chmod +x "$FLOPREFIX"usr/bin/aragon
sudo cat > "$FLOPREFIX"usr/share/applications/aragon.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Aragon
Comment=Participate on Internet-native organizations/enterprises (as BTC/ETH are the Internet-native money) or create your own!
Type=Application
Exec=aragon
Icon=aragon
Categories=Office;Blockchain;Finance;Ethereum;
Keywords=daos;govern;governance;organizations;decentralized;autonomous;tokens;ethereum;xdai;polygon
EOF
if [ ! -e /1/img/humanrepresentation ]; then sudo mkdir /1/img/humanrepresentation; fi
sudo ln -s /1/apps/aragon/action-create.ee78fef6.png /1/img/humanrepresentation/action-create.png
sudo ln -s /1/apps/aragon/activity-no-results.51fb2b93.png /1/img/humanrepresentation/look-at-phone.png

if [ "$(df ~ | tail -1 | awk '{print $1;}')" != "/cow" ]; then
echo "DEBUG: Not a Live ISO"
echo "Preparing to create your ETH address..."
bash "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/ethgenerate.sh
fi

sudo rmoriginal -rf "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon
