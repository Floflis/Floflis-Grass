#!/bin/bash

echo "Installing installer's slideshow..."
if [ -e /usr/share/ubiquity-slideshow ]; then
    if [ ! -e /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/welcome.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/screenshots/photos.png /usr/share/ubiquity-slideshow/slides/screenshots/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/icons/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/icons/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/icons/firefox.png /usr/share/ubiquity-slideshow/slides/icons/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/welcome.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/music.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/accessibility.html /usr/share/ubiquity-slideshow/slides/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/browse.html /usr/share/ubiquity-slideshow/slides/ubuntu
#-
    if [ ! -e /usr/share/ubiquity-slideshow/slides/link/ubuntu ]; then $maysudo mkdir /usr/share/ubiquity-slideshow/slides/link/ubuntu; fi
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/background.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/bullet-point.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-back.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
    $maysudo mv -f /usr/share/ubiquity-slideshow/slides/link/arrow-next.png /usr/share/ubiquity-slideshow/slides/link/ubuntu
#-    
    cd ubiquity-slideshow
    if [ ! -e .git ]; then git clone --no-checkout https://github.com/Floflis/ubiquity-slideshow.git .; fi
    if [ -e .git ]; then git pull; fi
#if failure, get from other sources (add to all other clonable resources)
    git checkout -f
    cd ..
    $maysudo rsync -av ubiquity-slideshow /usr/share
#    cd ubiquity-slideshow
#    rm -f .gitattributes #use noah to exclude everything except .git
#    rm -rf slides
#    rm -f slideshow.conf
#    cd "$SCRIPTPATH"
fi
