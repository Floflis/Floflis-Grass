#!/bin/bash

application_id="$(jq -r '.id' manifest.webapp)"
application_exportsfolder="$(jq -r '.floflispackager.exportsfolder' manifest.webapp)"
application_type="$(jq -r '.application' manifest.webapp)"
#rocketlaunch_dir="$(echo $PWD)"
rocketlaunch_dir="$(echo $PWD)/beepbox" #not the convention, but the only tangible way I found to simulate if the install.sh (this script) was running from ./beepbox!
#
#not part of floflis-packager's pack.sh -->
application_name="$(jq -r '.name' manifest.webapp)"
#<-- not part of floflis-packager's pack.sh

# FUTURELY PROBABLY WILL BE PART OF A FLOFLIS-PACKAGER METHOD ---->
echo "Installing $application_name [1/2]..."
unzip BeepBox_4_1.zip
rm -r __MACOSX
mv BeepBox_4_1 $application_id
cp manifest.webapp $application_id/
cp package.json $application_id/
cp main.js $application_id/

cd $application_id

ln -s /1/Floflis/libs/node_modules
ln -s apple-touch-icon.png icon.png

echo "Installing $application_name's icon..."
#cp -f --preserve=all apple-touch-icon.png /usr/share/icons/hicolor/scalable/apps/beepbox.png
cp -f --preserve=all ../include/icons/. /usr/share/icons/hicolor/
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f

echo "Converting $application_name's webapp to floapps..."
proceed () {
if [ "$application_type" = "app" ]; then
   application_extension="apps"
   #echo "apps"
fi

if [ "$application_type" = "game" ]; then
   application_extension="game"
   #echo "game"
fi

mkdir /tmp/floflis
mkdir /tmp/floflis/packager
mkdir /tmp/floflis/packager/application
#cp -r "$(echo $PWD)/beepbox/$application_exportsfolder" /tmp/floflis/packager/application/$application_id
cp -r "$(echo $PWD)/$application_exportsfolder" /tmp/floflis/packager/application/$application_id #modified from original floflis-packager, adding $PWD/$application_id(beepbox)
cp "$rocketlaunch_dir/manifest.webapp" /tmp/floflis/packager/manifest.webapp
cd "/tmp/floflis/packager/application/$application_id"
rm -rf .git #tmp, this will be moved into a pre/post hook
rm -rf .github #tmp, this will be moved into a pre/post hook
cd /tmp/floflis/packager
tar -czvf ../$application_id.$application_extension application manifest.webapp
mv -f $application_id.$application_extension "$rocketlaunch_dir"
rm -rf /tmp/floflis/packager/application
rm -f /tmp/floflis/packager/manifest.webapp
#cd "$rocketlaunch_dir" (ORIGINAL FROM FLOFLIS-PACKAGER)
cd "$rocketlaunch_dir" && cd ..
echo "Exported to $application_id.$application_extension!"
#exit 0
}

fail () {
echo "This application have no manifest.webapp."
echo "Please create it."
exit 1
}

if [ -f "$rocketlaunch_dir/manifest.webapp" ]; then # manifest.webapp file should always be at the root of the source
   proceed
else
   fail
fi
# <---- FUTURELY PROBABLY WILL BE PART OF A FLOFLIS-PACKAGER METHOD

#
#
#

echo "Installing $application_name [2/2]..."
#----> merge into floflis-packager/floflis-application-handler
tar -C /1/apps -xzf "$rocketlaunch_dir/$application_id.$application_extension"
mkdir /1/apps/$application_id
mv -f /1/apps/manifest.webapp /1/apps/$application_id/
cd /1/apps/application/$application_id
cp -rf . /1/apps/$application_id/
cd ../..
rm -rf application
#<---- merge into floflis-packager/floflis-application-handler
cd "$rocketlaunch_dir" && cd ..

#merge into floflis-packager/floflis-application-handler ---->
$maysudo cp -f "$application_id""-cli" "/usr/bin/$application_id"
$maysudo chmod +x /usr/bin/$application_id
$maysudo cat > /usr/share/applications/$application_id.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=BeepBox
Comment=BeepBox is a tool for sketching and sharing instrumental melodies.
Type=Application
Exec=beepbox
Icon=beepbox
Categories=Utility;AudioVideo;Audio;Player;Recorder;
Keywords=DAWs;Audio;Song;MP3;MIDI;Chiptunes;8Bit;Retro;Music;Compose;Create;Melody
EOF
# <-- HOME LAYER

echo "DEBUG: " && echo $PWD
#rm -r "$application_id"

echo "It seems that $application_name has been successfully installed!"

#echo "Installing icon for $application_name..."
#cp -f central.svg /usr/share/icons/hicolor/scalable/apps/
##cp -f scalable-max-16/ /usr/share/icons/hicolor/
#cp -f 16x16/ /usr/share/icons/hicolor/
#sudo gtk-update-icon-cache /usr/share/icons/hicolor/ -f
#<---- merge into floflis-packager/floflis-application-handler
