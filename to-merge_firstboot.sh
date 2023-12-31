#!/bin/bash

echo "This is the first boot (Soil/to-merge)."
#sudo mv "$FLOPREFIX"usr/lib/floflis/layers/core/firstlogon.sh /home
#sudo mv "$FLOPREFIX"usr/lib/floflis/layers/core/firstlogonroot.sh /home
#sudo chmod +x /home/firstlogon.sh
#sudo chmod +x /home/firstlogonroot.sh
cd /home
for D in `find . -mindepth 1 -maxdepth 1 -type d`
do
   pure=$(echo "${D}" | tr -d "/" | tr -d ".")
   cd ${D}
   
# mv to firstboot ---->
echo "Installing Templates of the 'New File' context menu..."
rsync -av "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-Templates/. /home/${flouser}/Templates
rmoriginal /home/${flouser}/Templates/New\ slidesPresentation.pptx.webpresent
rmoriginal /home/${flouser}/Templates/New\ Spreadsheet.xlsx.webpresent
rmoriginal /home/${flouser}/Templates/New\ WordWriter\ document.docx.webpresent
rmoriginal /home/${flouser}/Templates/New\ Access\ Database.accdb.webpresent
rmoriginal /home/${flouser}/Templates/"New Compressed (zipped) Folder.zip.webpresent"
rmoriginal /home/${flouser}/Templates/New\ Publisher\ Document.pub.webpresent
# <---- mv to firstboot

# mv to firstboot ---->
echo "Installing Sample Media..."
if [ ! -e /home/${flouser}/Pictures/Sample\ Photos ]; then mkdir /home/${flouser}/Pictures/Sample\ Photos; fi
if [ ! -e /home/${flouser}/Videos/Sample\ Videos ]; then mkdir /home/${flouser}/Videos/Sample\ Videos; fi
if [ ! -e /home/${flouser}/Music/Sample\ Music ]; then mkdir /home/${flouser}/Music/Sample\ Music; fi
cp '"$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Pictures/Sample Photos/Phabulous Pabllo Vittar 💞.jpeg' /home/${flouser}/Pictures/Sample\ Photos/
cp '"$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/Home/Videos/Sample Videos/Home Life - Animals.3gp' /home/${flouser}/Videos/Sample\ Videos/
# <---- mv to firstboot
   
if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
# start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'bash "$FLOPREFIX"usr/lib/cinnamobile/set_desktop.sh'
EOF
fi

if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then
echo "Setting up Cinnamon data..."
if [ ! -e /home/${pure}/.config/cinnamon ]; then mkdir /home/${pure}/.config/cinnamon; fi
if [ ! -e /home/${pure}/.config/cinnamon/spices ]; then mkdir /home/${pure}/.config/cinnamon/spices; fi
#tar -C /home/${flouser}/.cinnamon/configs -xzf "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs.tar.gz
rsync -av "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge/include-firstlogon/home-daniella-.cinnamon-configs/. /home/${pure}/.config/cinnamon/spices
fi

echo "Building your desktop experience [part 2/2]..."
if [ ! -e Pictures/Screenshots ]; then mkdir Pictures/Screenshots; fi
# start a new dbus session and execute the gsettings command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
exec dbus-run-session -- bash -c 'dconf write /org/gnome/gnome-screenshot/auto-save-directory "'~/Pictures/Screenshots'"'
EOF

# start a new dbus session and execute the gsettings command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
exec dbus-run-session -- bash -c 'dconf write /org/blueman/general/symbolic-status-icons true'
EOF

# to-merge>
#             if [ -f "$FLOPREFIX"usr/lib/floflis/layers/soil/firstlogon.sh ];then
#                installtermfont(){
                cat >> "$FLOPREFIX"tmp/org-gnome-terminal-legacy-profiles <<EOF
[/]
custom-command='nu'
bold-is-bright=true
font='FantasqueSansMono Nerd Font 12'
use-system-font=false
background-color='#282A36'
bold-color='#6E46A4'
bold-color-same-as-fg=false
foreground-color='#F8F8F2'
palette=['#262626', '#E356A7', '#42E66C', '#E4F34A', '#9B6BDF', '#E64747', '#75D7EC', '#EFA554', '#7A7A7A', '#FF79C6', '#50FA7B', '#F1FA8C', '#BD93F9', '#FF5555', '#8BE9FD', '#FFB86C']
use-theme-colors=false
EOF
                # start a new dbus session and execute the dconf command in bash shell. from https://askubuntu.com/a/1302886
sudo  -i -u ${pure} bash <<-EOF
   exec dbus-run-session -- bash -c 'dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < "$FLOPREFIX"tmp/org-gnome-terminal-legacy-profiles'
EOF
                rm -f "$FLOPREFIX"tmp/org-gnome-terminal-legacy-profiles
#}
#                echo "You have to logout, so changes will take effect."
#                echo "Save any work you did (only if you did)."
#                echo "Logout? [Y/n]"
#                read logoutinput;case $logoutinput in [nN]) break ;; [yY]) installtermfont;cinnamon-session-quit --logout --force; esac
#fi
# <to-merge
   
#   if [ ! -e .config ]; then mkdir .config; fi
#   if [ ! -e .config/autostart ]; then mkdir .config/autostart; fi
#   cd .config/autostart
#   cat > /home/$pure/.config/autostart/firstlogon.sh << ENDOFFILE
#[Desktop Entry]
#Type=Application
#Exec=gnome-terminal --tab --title="Welcome to Floflis! 👭" -- /bin/sh -c 'cd /home; sh ./firstlogon.sh; exec bash'
#Hidden=false
#NoDisplay=false
#X-GNOME-Autostart-enabled=true
#Name[en_US]=FirstLogon
#Name=FirstLogon
#Comment[en_US]=
#Comment=
#Icon=utilities-terminal
#StartupNotify=true
#Terminal=false
#
#ENDOFFILE
#   sudo chmod -R a+rwX /home/$pure/.config/autostart && sudo chown $pure:$pure /home/$pure/.config/autostart
#   sudo chown $pure:$pure /home/$pure/.local/share/gvfs-metadata/home*
#   sudo chmod +x /home/$pure/.config/autostart/firstlogon.sh
#   sudo chown $pure:$pure /home/$pure/.config/autostart/firstlogon.sh
#   cd .config/autostart
#   sudo mv /home/$pure/.config/autostart/firstlogon.sh /home/$pure/.config/autostart/firstlogon.desktop
#   sudo chown $pure:$pure /home/$pure/.config/autostart/firstlogon.desktop
#   cd ..
#   cd ..
#   echo "- Cleanning install..."
#   sudo rm -rf /home/$pure/.config/autostart/firstlogon.sh
   
   cd ..
   sudo chmod -R a+rwX ${D} && sudo chown $pure:$pure ${D}
   sudo chmod -R a+rwX /1 && sudo chown $pure:$pure /1
   sudo chmod -R a+rwX /1/config && sudo chown -R $pure:$pure /1/config #from https://askubuntu.com/a/693427
   sudo chmod -R a+rwX "$FLOPREFIX"usr/share/ubiquity-slideshow && sudo chown -R $pure:$pure "$FLOPREFIX"usr/share/ubiquity-slideshow
   sudo chmod -R a+rwX "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge && sudo chown -R $pure:$pure "$FLOPREFIX"usr/lib/floflis/layers/soil/to-merge
   if [ $(bash "$FLOPREFIX"usr/lib/floflis/layers/soil/tools/DEtector.sh) = "cinnamon" ];then sudo chmod -R a+rwX /home/$pure/.config/cinnamon && sudo chown -R $pure:$pure /home/$pure/.config/cinnamon;fi
done

