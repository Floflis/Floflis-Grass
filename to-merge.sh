#!/bin/bash

#- Floflis main Ubuntu ISO will use Ultimate layer. For Home layer, different ISO base: https://help.ubuntu.com/community/Installation/MinimalCD https://www.edivaldobrito.com.br/instalar-ambiente-cinnamon-3-0-no-ubuntu-16-04/

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
flouser=$(logname)

# load definitions & settings
. /usr/lib/floflis/./config

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

if [ -e /tmp/cubicmode ]; then
maysudo=""
fi

export maysudo

echo "Building your desktop experience [part 1/2]..."

echo "Installing gschemes..."
if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "gnome" ];then
      $maysudo cp -f include/System/gschemas/GNOME/01_org.gnome.gschema.override /usr/share/glib-2.0/schemas/
      sudo apt update
      sudo apt install gnome-shell-extensions gnome-shell-extension-prefs
      $maysudo cp -f include/System/gschemas/GNOME/extensions/01_org.gnome.extensions-arcmenu.gschema.override /usr/share/glib-2.0/schemas/
      $maysudo cp -f include/System/gschemas/GNOME/extensions/01_org.gnome.extensions-blur-my-shell.gschema.override /usr/share/glib-2.0/schemas/
      $maysudo cp -f include/System/gschemas/GNOME/extensions/01_org.gnome.extensions-dash-to-panel.gschema.override /usr/share/glib-2.0/schemas/
      $maysudo cp -f include/System/gschemas/GNOME/extensions/01_org.gnome.extensions-ding.gschema.override /usr/share/glib-2.0/schemas/
      $maysudo cp -f include/System/gschemas/GNOME/extensions/01_org.gnome.extensions-logo-widget.gschema.override /usr/share/glib-2.0/schemas/
fi
#-
if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
$maysudo cp -f include/System/gschemas/Cinnamon/01_org.cinnamon.gschema.override /usr/share/glib-2.0/schemas/
#$maysudo cp -f include/System/gschemas/Cinnamon/Cinnamobile/11_ubuntucinnamon-environment-desktop.gschema.override /usr/share/glib-2.0/schemas/ && $maysudo cp -f include/System/gschemas/Cinnamon/Cinnamobile/11_ubuntucinnamon-environment-mobile.gschema.override /usr/share/glib-2.0/schemas/
fi
#-
$maysudo cp -f include/System/gschemas/01_floflis-lightdm-theme.gschema.override /usr/share/glib-2.0/schemas/
$maysudo cp -f include/System/gschemas/01_floflis-common.gschema.override /usr/share/glib-2.0/schemas/
$maysudo glib-compile-schemas /usr/share/glib-2.0/schemas/

#$maysudo bash include/System/to-merge_deactivated.sh

$maysudo apt install snapd #from https://stackoverflow.com/a/68008068
$maysudo snap install core
$maysudo service snapd start
$maysudo systemctl start snapd.service
#from https://stackoverflow.com/a/62747900

echo "Installing important programs:"
echo "Installing nfc-setup (includes NFC Tools)..."
cd include/System/nfc-setup
if [ ! -e .git ]; then git clone --no-checkout https://github.com/danimesq/nfc-setup.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash ./install.sh
cd "$SCRIPTPATH"

# Install geth:
echo "Installing geth..."
$maysudo add-apt-repository ppa:ethereum/ethereum
$maysudo apt update
$maysudo apt install geth
echo "Testing if geth works:"
geth -h

echo "Installing Hugo (you did great, elder blogspot.com)..."
if [ "$flofarch" = "386" ]; then
   $maysudo dpkg -i --no-force-all --refuse-downgrade include/deb\ packages/hugo/hugo_0.89.2_Linux-32bit.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
   echo "Testing if Hugo works:"
   hugo -h
fi
if [ "$flofarch" = "amd64" ]; then
   $maysudo dpkg -i --no-force-all --refuse-downgrade include/deb\ packages/hugo/hugo_extended_0.110.0_linux-amd64.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
   echo "Testing if Hugo works:"
   hugo -h
fi

echo "Installing important libs:"
echo "Installing unzip..."
$maysudo apt install unzip -y

echo "Installing important apps:"
# HOME LAYER -->
if [ ! -e /1/apps ]; then echo "Creating HTML5 apps directory...";$maysudo mkdir /1/apps; fi
echo "Installing important apps[1/2]: Installing HTML5 apps..."
cd include/HTML5Apps/central && $maysudo bash install.sh
cd "$SCRIPTPATH"
#
cd include/HTML5Apps/webappforks/beepbox && $maysudo bash install.sh
cd "$SCRIPTPATH"
#
cd include/HTML5Apps/lab/david/explorer && bash install.sh
cd "$SCRIPTPATH"
#
cd include/HTML5Apps/lab/browsers && bash install.sh
cd "$SCRIPTPATH"
# <-- HOME LAYER
echo "Installing important apps[2/2]: Installing native apps..."
echo "Installing Clock..."
$maysudo apt install gnome-clocks -y
echo "Installing Contacts"
$maysudo apt install gnome-contacts -y # 3.279 kB of additional disk space will be used.
$maysudo apt --fix-broken install
echo "Installing Sticky Notes..." #https://www.edivaldobrito.com.br/sticky-notes-indicator/
$maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/indicator-stickynotes_1.0.1-0~ppa1_all.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
#$maysudo apt-add-repository ppa:umang/indicator-stickynotes
#$maysudo apt-get update
#$maysudo apt-get install indicator-stickynotes
$maysudo apt --fix-broken install
echo "Installing Paint..."
$maysudo apt install kolourpaint -y
$maysudo apt install breeze && $maysudo apt autoremove qt5ct #from https://askubuntu.com/a/1302913 and https://askubuntu.com/questions/1302794/kolourpaint-missing-all-icons-on-ubuntu-20-10#comment2215417_1302913
echo "Installing Photos..."
$maysudo apt install gnome-photos -y
echo "Installing Character Map..."
$maysudo apt install gnome-characters -y # 3.456 kB of additional disk space will be used.
echo "Installing SoundRecorder..."
$maysudo apt install gnome-sound-recorder -y
echo "Installing Cam..."
$maysudo apt install cheese -y #from https://linuxconfig.org/how-to-test-webcam-on-ubuntu-22-04-jammy-jellyfish
echo "Installing Weather..."
$maysudo apt install gnome-weather -y
echo "Installing Maps..."
$maysudo apt install gnome-maps -y # 3.448 kB of additional disk space will be used.

$maysudo bash include/Shortcuts/customShortcuts.sh

echo "Installing other apps:"
echo "Installing KeePassXC..."
$maysudo apt install keepassxc
echo "Installing Stacer..."
$maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/stacer_1.1.0_amd64.deb #from https://askubuntu.com/a/198445 (have to login and VOTE) # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
$maysudo apt upgrade stacer
$maysudo apt --fix-broken install
echo "Installing MS Teams..."
$maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/teams_1.5.00.23861_amd64.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
$maysudo apt --fix-broken install
#-
echo "Installing Gnome GAMES app (465 kB download; 2,745 kB installed)..."
$maysudo apt install gnome-games-app
echo "Installing Minetest..."
$maysudo apt install minetest
echo "Installing gbrainy..."
$maysudo apt install gbrainy
#$maysudo apt install supertux
echo "Installing Money Manager Ex (MMEX)..."
$maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/mmex_1.6.3-Ubuntu.22.04.jammy_amd64.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]

#echo "Installing xdotool..."
#$maysudo apt install xdotool
#echo "Is xdotool still useful?" # inspire on how firedoge is installed and how it opens an app without blocking the rest of script
#-
#ipfs init
#bash ipfsdaemon > ipfs.log &
#(ipfs daemon &)
#?xdotool key Ctrl+d
#?xdotool key Ctrl+d
#? on Cubic, need to have IPFS running on host - until its fixed
#check if issues have been fixed. also, Ubiquity post-install script which will include asking user to import Live ISO data to the newly installed OS

echo "Installing ipfs-handle..."
cat > /usr/share/applications/ipfs-handle-link.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Handler for ipfs:// URIs
Exec=xdg-open %u
StartupNotify=false
MimeType=x-scheme-handler/ipfs;
NoDisplay=true
EOF
if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
$maysudo echo "x-scheme-handler/ipfs=firedoge.desktop;firefox.desktop;" >> /usr/share/applications/x-cinnamon-mimeapps.list
fi

echo "Installing Frame"
$maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/frame_0.6.6_amd64.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
#- if ARM64: $maysudo dpkg -i --no-force-all --refuse-downgrade include/DEB/frame_0.6.6_arm64.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]

echo "Installing GDevelop..."
#      if [ "$flofarch" = "386" ]; then
#         tar -xzf include/HTML5Apps/386.tar.gz
#         rm -f go-ipfs/install.sh && rm -f go-ipfs/LICENSE && rm -f go-ipfs/README.md
#         $maysudo mv go-ipfs/ipfs /usr/bin
#         $maysudo rm -rf go-ipfs
#         chmod +x /usr/bin/ipfs
#         echo "Testing if IPFS works:"
#         ipfs
#fi
#-
if [ "$flofarch" = "amd64" ]; then
   tar -xzf include/HTML5Apps/gdevelop_amd64.tar.gz
   $maysudo rsync -av gdevelop /1/apps
   chmod +x /1/apps/gdevelop/gdevelop
   rm -rf gdevelop
   cat > /usr/bin/gdevelop <<EOF
#!/bin/bash

cd /1/apps/gdevelop/
./gdevelop
EOF
   $maysudo chmod +x /usr/bin/gdevelop
   cat > /usr/share/applications/gdevelop.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=GDevelop
Comment=Make games easily even if you don't know to program; even your grandma can.
Type=Application
Exec=gdevelop
Icon=gdevelop
Categories=Programming;Games;
Keywords=programming;games;event-sheet;development;
EOF
fi

echo "Installing Weblink apps/shortcuts..."
cd include/Shortcuts/WeblinkApps
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/WeblinkApps.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo bash install.sh
cd "$SCRIPTPATH"

# Floflis Icons
cd include/img/icons
$maysudo bash install.sh
cd "$SCRIPTPATH"

echo "Installing branding..."
if [ ! -e /usr/share/cups/data/ubuntu ]; then $maysudo mkdir /usr/share/cups/data/ubuntu; fi
$maysudo mv -f /usr/share/cups/data/default-testpage.pdf /usr/share/cups/data/ubuntu/default-testpage.pdf
$maysudo cp -f include/img/default-testpage.pdf /usr/share/cups/data/default-testpage.pdf

echo "Installing img..."
if [ ! -e /1/img ]; then $maysudo mkdir /1/img; fi
#-
$maysudo cp -f include/img/OSlogotype.svg /1/img/OSlogotype.svg
$maysudo cp -f include/img/logo.svg /1/img/logo.svg

$maysudo apt --fix-broken install #currently required hack as mmex has f'ed our dependencies
$maysudo apt install libpng-dev libjpeg-dev libtiff-dev imagemagick -y #from https://www.linuxcapable.com/how-to-install-imagemagick-on-ubuntu-linux/
#Need to get 4,103 kB of archives. After this operation, 15.0 MB of additional disk space will be used.

cd include/img/watermarkmaker
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/watermarkmaker.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
bash run.sh
until [ -f watermark.png ]
do
   sleep 1s
done
$maysudo cp -f watermark.png /1/img/watermark.png
rm watermark_template.png
rm watermark.png
cd "$SCRIPTPATH"

#-
if [ ! -e /1/img/networks ]; then $maysudo mkdir /1/img/networks; fi
$maysudo cp -f include/img/networks/ethereum.svg /1/img/networks/ethereum.svg
$maysudo cp -f include/img/networks/polygon.svg /1/img/networks/polygon.svg
$maysudo cp -f include/img/networks/optimism.svg /1/img/networks/optimism.svg
$maysudo cp -f include/img/networks/gnosis.svg /1/img/networks/gnosis.svg
$maysudo cp -f include/img/networks/ronin.svg /1/img/networks/ronin.svg
$maysudo cp -f include/img/networks/base.svg /1/img/networks/base.svg
$maysudo cp -f include/img/networks/arbitrum.svg /1/img/networks/arbitrum.svg
$maysudo cp -f include/img/networks/bsc.svg /1/img/networks/bsc.svg
$maysudo cp -f include/img/networks/zksyncera.svg /1/img/networks/zksyncera.svg
$maysudo cp -f include/img/networks/linea.svg /1/img/networks/linea.svg
$maysudo cp -f include/img/networks/celo.svg /1/img/networks/celo.svg
$maysudo cp -f include/img/networks/immutablex.svg /1/img/networks/immutablex.svg
$maysudo cp -f include/img/networks/immutablezkevm.svg /1/img/networks/immutablezkevm.svg
$maysudo cp -f include/img/networks/loopring.svg /1/img/networks/loopring.svg
$maysudo cp -f include/img/networks/starknet.svg /1/img/networks/starknet.svg
$maysudo cp -f include/img/networks/metis.svg /1/img/networks/metis.svg
$maysudo cp -f include/img/networks/dydx.svg /1/img/networks/dydx.svg
$maysudo cp -f include/img/networks/polygonzkevm.svg /1/img/networks/polygonzkevm.svg
#-
$maysudo cp -f include/img/token.svg /1/img/token.svg

echo "Deep branding replacements:"
#/usr/share/pixmaps
if [ ! -e /usr/share/pixmaps/ubuntu ]; then $maysudo mkdir /usr/share/pixmaps/ubuntu; if [ -f /usr/share/pixmaps/ubuntu-logo.svg ]; then $maysudo mv -f /usr/share/pixmaps/ubuntu-logo.svg /usr/share/pixmaps/ubuntu; ln -s /1/img/logo.svg /usr/share/pixmaps/ubuntu-logo.svg; fi; if [ -f /usr/share/pixmaps/ubuntu-logo-text-dark.png ]; then $maysudo mv -f /usr/share/pixmaps/ubuntu-logo-text-dark.png /usr/share/pixmaps/ubuntu; $maysudo convert include/img/floflis-logo.png    -resize 256x89  /usr/share/pixmaps/ubuntu-logo-text-dark.png; fi; if [ -f /usr/share/pixmaps/ubuntu-logo-dark.png ]; then $maysudo mv -f /usr/share/pixmaps/ubuntu-logo-dark.png /usr/share/pixmaps/ubuntu; $maysudo convert include/img/floflis-logo.png    -resize 256x89  /usr/share/pixmaps/ubuntu-logo-dark.png; fi; if [ -f /usr/share/pixmaps/ubuntu-logo-icon.png ]; then $maysudo mv -f /usr/share/pixmaps/ubuntu-logo-icon.png /usr/share/pixmaps/ubuntu; $maysudo convert include/img/pixmaps/floflis-logo-black.png    -resize 260x91  /usr/share/pixmaps/ubuntu-logo-icon.png; fi; if [ -f /usr/share/pixmaps/ubuntu-logo-text.png ]; then $maysudo mv -f /usr/share/pixmaps/ubuntu-logo-text.png /usr/share/pixmaps/ubuntu; $maysudo convert include/img/pixmaps/floflis-logo-black.png    -resize 260x91  /usr/share/pixmaps/ubuntu-logo-text.png; fi; $maysudo ln -sf ubuntu-logo-dark.png /usr/share/pixmaps/ubuntu/ubuntu-logo-text-dark.png; $maysudo ln -sf ubuntu-logo-icon.png /usr/share/pixmaps/ubuntu/ubuntu-logo-text.png; fi

echo "Installing backgrounds..."
cd include/img/Backgrounds
$maysudo cp -f parul-gupta-zhci1QZZJDU-unsplash.jpg /1/img/bg.jpg
$maysudo cp -f lockscreen.png /1/img/lockscreen.png
#-
if [ ! -e /usr/share/backgrounds/ubuntu ]; then $maysudo mkdir /usr/share/backgrounds/ubuntu; fi

if [ -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_dark.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_dark.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_light.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Kinetic_Kudu_by_Joshua_T_light.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Kudu_Wallpaper_Grey_4096x2304.png ]; then $maysudo mv -f /usr/share/backgrounds/Kudu_Wallpaper_Grey_4096x2304.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png ]; then $maysudo mv -f /usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Obersee_by_Uday_Nakade.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Obersee_by_Uday_Nakade.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Reflection_by_Juliette_Taka.png ]; then $maysudo mv -f /usr/share/backgrounds/Reflection_by_Juliette_Taka.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Saffron_by_Rakesh_Yadav.png ]; then $maysudo mv -f /usr/share/backgrounds/Saffron_by_Rakesh_Yadav.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Sunset_Over_Lake_Lugano_by_Alexey_Kulik.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Sunset_Over_Lake_Lugano_by_Alexey_Kulik.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Twisted_Gradients_by_Gustavo_Brenner.png ]; then $maysudo mv -f /usr/share/backgrounds/Twisted_Gradients_by_Gustavo_Brenner.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Copper_Mountain_by_Eduardo_Battaglia.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Copper_Mountain_by_Eduardo_Battaglia.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Flow_by_Emanuele_Santoro.png ]; then $maysudo mv -f /usr/share/backgrounds/Flow_by_Emanuele_Santoro.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Lobster_Wallpaper_Grey.png ]; then $maysudo mv -f /usr/share/backgrounds/Lobster_Wallpaper_Grey.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/LunarCatcher_by_Espio347.png ]; then $maysudo mv -f /usr/share/backgrounds/LunarCatcher_by_Espio347.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Lunar-lobster-side_by_Gixo-dark.png ]; then $maysudo mv -f /usr/share/backgrounds/Lunar-lobster-side_by_Gixo-dark.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Lunar-lobster-side_by_Gixo-light.png ]; then $maysudo mv -f /usr/share/backgrounds/Lunar-lobster-side_by_Gixo-light.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Multiverse_by_Emanuele_Santoro.png ]; then $maysudo mv -f /usr/share/backgrounds/Multiverse_by_Emanuele_Santoro.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Startrail_by_Hajime_Mizuno.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Startrail_by_Hajime_Mizuno.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/Warm_Filament_by_Eduardo_Battaglia.jpg ]; then $maysudo mv -f /usr/share/backgrounds/Warm_Filament_by_Eduardo_Battaglia.jpg /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/warty-final-ubuntu.png ]; then $maysudo mv -f /usr/share/backgrounds/warty-final-ubuntu.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/winter-is-leaving_by_Gixo-dark.png ]; then $maysudo mv -f /usr/share/backgrounds/winter-is-leaving_by_Gixo-dark.png /usr/share/backgrounds/ubuntu; fi
if [ -f /usr/share/backgrounds/winter-is-leaving_by_Gixo-light.png ]; then $maysudo mv -f /usr/share/backgrounds/winter-is-leaving_by_Gixo-light.png /usr/share/backgrounds/ubuntu; fi

if [ ! -e /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon ]; then $maysudo mkdir /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon; fi

$maysudo mv -f /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntu_cinnamon_kinetic_kudu.jpg /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntucinnamon/ubuntu_cinnamon_kinetic_kudu.jpg
$maysudo ln -s /1/img/bg.png /usr/share/backgrounds/ubuntucinnamon/kinetic/ubuntu_cinnamon_kinetic_kudu.jpg
#-
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/BackgroundsImg.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av Backgrounds/. /usr/share/backgrounds
#-
$maysudo cp -f floflis-backgrounds.xml /usr/share/gnome-background-properties/floflis-backgrounds.xml
cd "$SCRIPTPATH"

echo "Updating default background..."
if [ ! -e /usr/share/wallpapers/FuturePrototype/debian ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/debian; fi
if [ -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/contents /usr/share/wallpapers/FuturePrototype/debian/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents; fi
if [ ! -e /usr/share/wallpapers/FuturePrototype/contents/images ]; then $maysudo mkdir /usr/share/wallpapers/FuturePrototype/contents/images; fi
if [ -f /usr/share/wallpapers/FuturePrototype/gnome-background.xml ]; then $maysudo mv /usr/share/wallpapers/FuturePrototype/gnome-background.xml /usr/share/wallpapers/FuturePrototype/debian/gnome-background.xml; fi
$maysudo ln -s /1/img/bg.png /usr/share/wallpapers/FuturePrototype/contents/images/1680x1050.png

# Cinnamon pre-installed avatars
cd include/img/Avatars && $maysudo bash install.sh
cd "$SCRIPTPATH"

echo "Installing sounds..."
$maysudo dpkg -i --no-force-all --refuse-downgrade include/sounds/ubuntu-touch-sounds_15.08_all.deb # flags insp from https://askubuntu.com/a/441829 and https://askubuntu.com/a/442171 [HAVE TO UPVOTE]
if [ ! -e /1/sounds ]; then $maysudo mkdir /1/sounds; fi
$maysudo cp -f include/sounds/presentation.ogg /1/sounds/presentation.ogg

#- Deduplicate Ubuntu's login sound
if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then
if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then
$maysudo rm -f /usr/share/sounds/Yaru/stereo/system-ready.oga && $maysudo ln -s 'desktop-login.oga' /usr/share/sounds/Yaru/stereo/system-ready.oga
fi
fi

# Patch alarm clock sound for Yaru sounds
if [ ! -e /usr/share/sounds/freedesktop/stereo/ubuntu ]; then $maysudo mkdir /usr/share/sounds/freedesktop/stereo/ubuntu; if [ -f /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga ]; then $maysudo mv -f /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga /usr/share/sounds/freedesktop/stereo/ubuntu; fi; fi
$maysudo ln -sf ../../ubuntu/ringtones/Counterpoint.ogg /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga

# BASE LAYER -->
# Base sounds
$maysudo cp -f include/sounds/Base/Changing\ volume.ogg /1/sounds/Changing\ volume.ogg
$maysudo cp -f include/sounds/Base/Inserting\ device.ogg /1/sounds/Inserting\ device.ogg
if [ ! -f /1/sounds/Leaving.ogg ]; then $maysudo cp -f include/sounds/Base/Leaving.ogg /1/sounds/Leaving.ogg; fi
$maysudo cp -f include/sounds/Base/Manipulating\ windows.ogg /1/sounds/Manipulating\ windows.ogg
$maysudo cp -f include/sounds/Base/Notification.oga /1/sounds/Notification.oga
$maysudo cp -f include/sounds/Base/Removing\ device.ogg /1/sounds/Removing\ device.ogg
$maysudo cp -f include/sounds/Base/Switching\ workspace.ogg /1/sounds/Switching\ workspace.ogg
if [ ! -f /1/sounds/Starting.oga ]; then $maysudo cp -f include/sounds/Base/Starting.oga /1/sounds/Starting.oga; fi

if [ ! -e /usr/share/sounds/Yaru/stereo/ubuntu ]; then $maysudo mkdir /usr/share/sounds/Yaru/stereo/ubuntu; if [ -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/desktop-login.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi; if [ -f /usr/share/sounds/Yaru/stereo/system-ready.oga ]; then $maysudo mv -f /usr/share/sounds/Yaru/stereo/system-ready.oga /usr/share/sounds/Yaru/stereo/ubuntu; fi; fi
if [ ! -f /usr/share/sounds/Yaru/stereo/desktop-login.oga ]; then $maysudo ln -s /1/sounds/Starting.oga /usr/share/sounds/Yaru/stereo/desktop-login.oga; fi
# <-- BASE LAYER

# HOME LAYER -->
# Home sounds patch
$maysudo cp -f include/sounds/Base/Home/Dialog.ogg /1/sounds/Dialog.ogg
$maysudo cp -f include/sounds/Base/Home/Navigation.ogg /1/sounds/Navigation.ogg
$maysudo cp -f include/sounds/Base/Home/Notification.oga /1/sounds/Notification.oga
$maysudo cp -f include/sounds/Base/Home/Notification\ Important.flac /1/sounds/Notification\ Important.flac
$maysudo cp -f include/sounds/Base/Home/System\ Logon.oga /1/sounds/System\ Logon.oga
if [ -f /1/sounds/Starting.oga ]; then $maysudo rm -f /1/sounds/Starting.oga; fi
$maysudo ln -s /1/sounds/System\ Logon.oga /1/sounds/Starting.oga
$maysudo ln -s /usr/share/sounds/ubuntu/ringtones/Celestial.ogg /1/sounds/Launcher.ogg
$maysudo ln -s /usr/share/sounds/ubuntu/ringtones/Ubuntu.ogg /1/sounds/Call.ogg
# <-- HOME LAYER

if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
echo "Installing Cinnamon zombiespices'..."
cd include/System/zombiespices
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/zombiespices.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
cd "$SCRIPTPATH"

echo "Installing Cinnamon applets, desklets and extensions..."
cd include/usr-share-cinnamon

if [ ! -e /usr/share/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon; fi

function job_mkCinnSysFolds {
if [ ! -e /usr/share/cinnamon/"$currentspicetype""s" ]; then $maysudo mkdir /usr/share/cinnamon/"$currentspicetype""s"; fi
}

function job_installSpice {
wget -N https://cinnamon-spices.linuxmint.com/files/"$currentspicetype""s"/$currentspice.zip
# from https://serverfault.com/a/379060/923518
if [ -f $currentspice.zip.1 ]; then rm $currentspice.zip; mv $currentspice.zip.1 $currentspice.zip; fi
unzip $currentspice.zip
$maysudo rsync -av "$currentspice"/. /usr/share/cinnamon/"$currentspicetype""s"/$currentspice
rm -r "$currentspice"
}

currentspicetype="applet"
cd "$currentspicetype""s"

job_mkCinnSysFolds

#currentspice="CinnVIIStarkMenu@NikoKrause"
#currentspicemintid="281"
#job_installSpice

currentspice="windowlist@cobinja.de"
currentspicemintid="287"
job_installSpice

currentspice="weather@mockturtl"
currentspicemintid="17"
job_installSpice

currentspice="Cinnamenu@json"
currentspicemintid="322"
job_installSpice

currentspice="search-box@mtwebster"
currentspicemintid="57"
job_installSpice

currentspice="ScreenShot+RecordDesktop@tech71"
currentspicemintid="41"
job_installSpice

currentspicetype="desklet"
cd ..
cd "$currentspicetype""s"

job_mkCinnSysFolds

currentspice="calendar@deeppradhan"
currentspicemintid="40"
job_installSpice

currentspice="bbcwx@oak-wood.co.uk"
currentspicemintid="20"
job_installSpice

currentspice="analog-clock@cobinja.de"
currentspicemintid="7"
job_installSpice

currentspicetype="extension"
cd ..
cd "$currentspicetype""s"

job_mkCinnSysFolds

currentspice="transparent-panels@germanfr"
currentspicemintid="81"
job_installSpice

#-

cd applets
unzip CinnXIStarkMenu@floflis.eth.zip
$maysudo rsync -av CinnXIStarkMenu@floflis.eth/. /usr/share/cinnamon/applets/CinnXIStarkMenu@floflis.eth
rm -r CinnXIStarkMenu@floflis.eth
#-
unzip super-window-list@floflis.eth.zip
$maysudo rsync -av super-window-list@floflis.eth/. /usr/share/cinnamon/applets/super-window-list@floflis.eth
rm -r super-window-list@floflis.eth

cd "$SCRIPTPATH"

echo "Installing cinnamon-patch..."
cd include/System/DE/cinnamon-patch
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/cinnamon-patch.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x patch.sh && $maysudo bash patch.sh
cd "$SCRIPTPATH"
fi #begin of this fi is detecting cinnamon

echo "Installing the Blockchain menu category..."
cd include/System/DE/menu-categories
$maysudo bash menucategory.sh
cd "$SCRIPTPATH"

if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
echo "Installing Cinnamobile..."
cd include/System/Cinnamobile
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/Cinnamobile.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash install.sh
cd "$SCRIPTPATH"
fi

echo "Installing bootscreen logotype..."
if [ ! -e /usr/share/plymouth/ubuntu ]; then $maysudo mkdir /usr/share/plymouth/ubuntu; $maysudo mv -f /usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/ubuntu; fi
$maysudo convert include/img/19logotypecolor.png    -resize 512x59  /usr/share/plymouth/ubuntu-logo.png # Plymouth logo
#$maysudo cp -f include/img/floflis-logo.png /usr/share/plymouth/ubuntu-logo.png
$maysudo cp -f include/img/floflis-logo.svg /1/img/floflis-logo.svg

#if [ ! -e /usr/share/plymouth/ubuntucinnamon ]; then $maysudo mkdir /usr/share/plymouth/ubuntucinnamon; $maysudo mv -f /usr/share/plymouth/ubuntucinnamon-logo.png /usr/share/plymouth/ubuntucinnamon; fi
#if [ ! -f /usr/share/plymouth/ubuntucinnamon-logo.png ]; then $maysudo ln -s ubuntu-logo.png /usr/share/plymouth/ubuntucinnamon-logo.png; fi
#if [ ! -f /usr/share/plymouth/ubuntucinnamon-logo.svg ]; then $maysudo ln -s ubuntu-logo.svg /usr/share/plymouth/ubuntucinnamon-logo.svg; fi
#-
#if [ ! -e /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu ]; then $maysudo mkdir /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu; $maysudo mv -f /usr/share/plymouth/themes/ubuntucinnamon-spinner/watermark.png /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu; $maysudo ln -s ../../ubuntu-logo.png /usr/share/plymouth/themes/ubuntucinnamon-spinner/watermark.png; $maysudo mv -f /usr/share/plymouth/themes/ubuntucinnamon-spinner/bgrt-fallback.png /usr/share/plymouth/themes/ubuntucinnamon-spinner/ubuntu; $maysudo convert include/img/logo.png    -resize 128x128  /usr/share/plymouth/themes/ubuntucinnamon-spinner/bgrt-fallback.png; fi

echo "Installing Floflis bootscreen (Plymouth) theme..."
cd include/System/Boot/floflis-plymouth
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/floflis-plymouth.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
bash install.sh
cd "$SCRIPTPATH"
$maysudo update-initramfs -k all -u #from Ubuntu Cinnamon Remix scripts
$maysudo update-initramfs -u #from https://askubuntu.com/a/1290247

echo "Installing themes:"
echo "Installing Yaru-floflis theme..."
cd include/Theme/Yaru-floflis
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/Yaru-floflis.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av . /usr/share/themes/Yaru-floflis
$maysudo rm -rf /usr/share/themes/Yaru-floflis/.git
cd "$SCRIPTPATH"
#-
echo "Installing Yaru-floflis-dark theme..."
cd include/Theme/Yaru-floflis-dark
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/Yaru-floflis-dark.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av . /usr/share/themes/Yaru-floflis-dark
$maysudo rm -rf /usr/share/themes/Yaru-floflis-dark/.git
cd "$SCRIPTPATH"
#-
echo "Installing Yaru-floflis-light theme..."
cd include/Theme/Yaru-floflis-light
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/Yaru-floflis-light.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av . /usr/share/themes/Yaru-floflis-light
$maysudo rm -rf /usr/share/themes/Yaru-floflis-light/.git
cd "$SCRIPTPATH"
#-
echo "Installing Yaru-floflis-experience theme..."
cd include/Theme/Yaru-floflis-experience
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/Yaru-floflis-experience.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
$maysudo rsync -av . /usr/share/themes/Yaru-floflis-experience
$maysudo rm -rf /usr/share/themes/Yaru-floflis-experience/.git
cd "$SCRIPTPATH"
$maysudo rm -rf /usr/share/themes/Yaru-cinnamon
$maysudo rm -rf /usr/share/themes/Yaru-cinnamon-dark
#task: use function and variable to reduce duplications

#echo "----------------------------------------------------------------------"
#echo "DEBUG:"
#echo "Script path: $SCRIPTPATH" && echo "Current directory: $(pwd)"
#echo "ls:" && ls
#echo "----------------------------------------------------------------------"

echo "Adding bulbasaur.json..."
$maysudo cp -f include/System/bulbasaur.json /1/bulbasaur.json

#gnome-terminal --tab --title="Installing NodeJS" -- /bin/sh -c 'bash install-node.sh; exec bash'
#(gnome-terminal --tab --title="Installing NodeJS..." -- /bin/sh -c 'bash install-node.sh; exec bash' &)

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $SCRIPTPATH" && echo "Current directory: $(pwd)"
echo "ls:" && ls
echo "----------------------------------------------------------------------"

echo "Installing Floflis' Feofle..."
cd include/System/feofle
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/feofle.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash install.sh
cd "$SCRIPTPATH"
echo "Testing if feofle works:"
feofle

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $SCRIPTPATH" && echo "Current directory: $(pwd)"
echo "ls:" && ls
echo "----------------------------------------------------------------------"

echo "Installing UniStore..."
cd include/System/unistore-core
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/unistore-core.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo sh ./install.sh
cd "$SCRIPTPATH"
echo "Testing if UniStore CLI works:"
unistore

echo "Installing Floflis' flo-bkp-sync..."
cd include/System/flo-bkp-sync
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/flo-bkp-sync.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash install.sh
cd "$SCRIPTPATH"
echo "Testing if flo-bkp-sync works:"
flo-bkp-sync

echo "Installing Web3Updater..."
cd include/System/Web3Updater
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Plasmmer/Web3Updater.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash install.sh
cd "$SCRIPTPATH"
echo "Testing if Web3Updater works:"
web3updater

echo "Installing SharedChain..."
cd include/System/SharedChain
if [ ! -e .git ]; then git clone --no-checkout https://github.com/Plasmmer/SharedChain.git .; fi
if [ -e .git ]; then git pull; fi
git checkout -f
chmod +x install.sh && $maysudo bash install.sh
cd "$SCRIPTPATH"
echo "Testing if SharedChain works:"
sharedchain

if [ $(bash /usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
echo "Attempting to upgrade Cinnamon..."
$maysudo apt upgrade cinnamon-desktop-environment
$maysudo apt install ubuntucinnamon-desktop
$maysudo apt upgrade ubuntucinnamon-desktop
$maysudo apt-get autoremove
$maysudo apt-get autoclean
$maysudo apt --fix-broken install
echo "Upgrading other packages..."
$maysudo apt upgrade gir1.2-mutter-12 libmutter-12-0 mutter-common mutter-common-bin
$maysudo apt upgrade gnome-control-center gnome-control-center-data gnome-control-center-faces gnome-shell gnome-shell-common
#cinnamon patcher (cinnamon-patch) here
fi

$maysudo apt-get install dialog #1.254 kB of additional disk space
$maysudo apt-get install ppa-purge #Need to get 6.566 B of archives. After this operation, 24,6 kB of additional disk space will be used.

if [ -e /tmp/cubicmode ]; then
echo "Cubic mode has been detected, so let's try to fix Ubuntu 23.04's Flutter ISO issues"
#snap remove ubuntu-desktop-installer
#snap install ubuntu-desktop-installer --classic
#-
#sudo apt-get install ubiquity ubiquity-frontend-gtk #from https://askubuntu.com/questions/995980/how-to-install-ubiquity-to-full-install-bootable-usb
apt update
apt install ubiquity ubiquity-casper ubiquity-frontend-gtk ubiquity-slideshow-ubuntu ubiquity-ubuntu-artwork #from https://github.com/PJ-Singh-001/Cubic/issues/151
#-
# Ubiquity
#Slideshow
cd include/System
$maysudo bash ubiquity-slideshow.sh
cd "$SCRIPTPATH"
#Pixmaps
if [ ! -e /usr/share/ubiquity/pixmaps/ubuntuoriginal ]; then $maysudo mkdir /usr/share/ubiquity/pixmaps/ubuntuoriginal; $maysudo mv -f /usr/share/ubiquity/pixmaps/ubuntu /usr/share/ubiquity/pixmaps/ubuntuoriginal/; $maysudo mv -f /usr/share/ubiquity/pixmaps/ubuntu/cd_in_tray.png /usr/share/ubiquity/pixmaps/ubuntuoriginal;$maysudo mv -f /usr/share/ubiquity/pixmaps/ubuntu/ubuntu_installed.png /usr/share/ubiquity/pixmaps/ubuntuoriginal; fi
#-
$maysudo rsync -av include/System/ubiquity/pixmaps/. /usr/share/ubiquity/pixmaps
fi

echo "Upgrading packages and distro packages..."
$maysudo apt upgrade -y #from https://linuxhint.com/update_all_packages_ubuntu/
$maysudo apt-get autoremove
$maysudo apt-get autoclean
$maysudo apt dist-upgrade
$maysudo apt-get autoremove
$maysudo apt-get autoclean
#-from https://elias.praciano.com/2014/08/apt-get-quais-as-diferencas-entre-autoremove-autoclean-e-clean/
$maysudo apt --fix-broken install

#- attempt to fix Cubic's custom name:
#$maysudo sed -i 's/^PRETTY_NAME=" .*$/PRETTY_NAME=" Floflis 19 build 2304_2 Eusoumafoca"/' /usr/lib/os-release
#$maysudo sed -i 's/^DISTRIB_DESCRIPTION=" .*$/DISTRIB_DESCRIPTION=" Floflis 19 build 2304_2 Eusoumafoca"/' /etc/lsb-release
$maysudo sed -i "s/PRETTY_NAME=\"Ubuntu 23.04\"/PRETTY_NAME=\"$osname $osversion\"/g" /usr/lib/os-release
$maysudo sed -i 's/HOME_URL="https:\/\/www.ubuntu.com\/"/HOME_URL="https:\/\/www.floflis.com\/"/g' /usr/lib/os-release
$maysudo sed -i 's/LOGO=ubuntu-logo/LOGO=floflis-logo/g' /usr/lib/os-release
$maysudo sed -i "s/DISTRIB_DESCRIPTION=\"Ubuntu 23.04\"/DISTRIB_DESCRIPTION=\"$osname $osversion\"/g" /etc/lsb-release
$maysudo sed -i "s/NAME=\"Ubuntu\"/NAME=\"$osname\"/g" /usr/lib/os-release
$maysudo sed -i "s/VERSION_ID=\"23.04\"/VERSION_ID=\"$osversion\"/g" /usr/lib/os-release
$maysudo sed -i "s/VERSION=\"23.04 (Lunar Lobster)\"/VERSION=\"$(echo $osbuild | tr "_" .) ($(echo $osbuildcodename | tr '[:upper:]' '[:lower:]' | tr -d '"'))\"/g" /usr/lib/os-release
#thanks to https://stackoverflow.com/a/5928159, https://stackoverflow.com/a/2264537 and https://stackoverflow.com/a/26314887 (have to login and VOTE)
#this bugs apt: $maysudo sed -i "s/VERSION_CODENAME=lunar/VERSION_CODENAME=$(echo $osbuildcodename | tr '[:upper:]' '[:lower:]' | tr -d '"')/g" /usr/lib/os-release
#thanks to https://askubuntu.com/a/76842 (have to login and VOTE)
if [ ! -f /etc/floflis-release ]; then $maysudo touch /etc/floflis-release; fi #enable Floflis to be detected by applications (such as Neofetch)
