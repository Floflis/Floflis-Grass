#echo "Installing Cinnamon 4.8..."
#$maysudo add-apt-repository ppa:wasta-linux/cinnamon-4-8
#$maysudo apt update
#$maysudo apt install cinnamon-desktop-environment
##https://www.tecmint.com/install-cinnamon-desktop-in-ubuntu-fedora-workstations/
#$maysudo apt --fix-broken install
#- detect ubuntu cinnamon remix otherwise install cinnamon normally. but not from that PPA!





#echo "Installing main theme..."
#tar -xzf include/Theme/Eleganse-Floflis.tar.gz
#$maysudo rsync -av Eleganse-Floflis /usr/share/themes
#$maysudo rm -rf Eleganse-Floflis
##$maysudo rm -rf /usr/share/themes/Eleganse-Floflis/.git
##-
#tar -xzf include/Theme/Adapta.tar.gz
#$maysudo rsync -av Adapta /usr/share/themes
#$maysudo rm -rf Adapta
##-
#tar -xzf include/Theme/Adapta-Nokto.tar.gz
#$maysudo rsync -av Adapta-Nokto /usr/share/themes
#$maysudo rm -rf Adapta-Nokto





# temporarily disable "Installing logon design" until fixed for Ubuntu 22.10 ---->
#echo "Installing logon design..."
#cd include/Theme/ubuntu-gdm-set-background
#if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ubuntu-gdm-set-background.git .; fi
#if [ -e .git ]; then git pull; fi
#git checkout -f
#$maysudo ./ubuntu-gdm-set-background --gradient horizontal \#F19399 \#61EACA
##-from https://www.omgubuntu.co.uk/2022/01/change-ubuntu-login-screen-background
##rm -f ubuntu-gdm-set-background #use noah to exclude everything except .git
##rm -f README.md
##rm -f LICENSE
#cd "$SCRIPTPATH"
# <---- temporarily disable "Installing logon design" until fixed for Ubuntu 22.10
#-
