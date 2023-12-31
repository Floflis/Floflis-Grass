rocketlaunch_dir=`pwd` #from https://unix.stackexchange.com/a/52919/470623

echo "Installing avatars..."
if [ ! -e /usr/share/pixmaps/faces/ubuntu ]; then $maysudo mkdir /usr/share/pixmaps/faces/ubuntu; $maysudo mv /usr/share/pixmaps/faces/legacy/ /usr/share/pixmaps/faces/*.jpg /usr/share/pixmaps/faces/*.png /usr/share/pixmaps/faces/ubuntu; fi

if [ ! -e /usr/share/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon; fi
if [ ! -e /usr/share/cinnamon/faces ]; then $maysudo mkdir /usr/share/cinnamon/faces; fi
if [ ! -e /usr/share/cinnamon/faces/cinnamon ]; then $maysudo mkdir /usr/share/cinnamon/faces/cinnamon; if [ -f /usr/share/cinnamon/faces/user-generic.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/user-generic.png /usr/share/cinnamon/faces/cinnamon; fi; fi

if [ -f /usr/share/cinnamon/faces/0_cars.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/0_cars.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_chess.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/chess.jpg /usr/share/cinnamon/faces/0_chess.jpg; $maysudo mv -f /usr/share/cinnamon/faces/0_chess.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_coffee.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/coffee.jpg /usr/share/cinnamon/faces/0_coffee.jpg; $maysudo mv -f /usr/share/cinnamon/faces/0_coffee.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/0_guitar.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/guitar.jpg /usr/share/cinnamon/faces/0_guitar.jpg; $maysudo mv -f /usr/share/cinnamon/faces/0_guitar.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_10.png ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/soccerball.png /usr/share/cinnamon/faces/2_10.png; $maysudo mv -f /usr/share/cinnamon/faces/2_10.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_11.png ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/baseball.png /usr/share/cinnamon/faces/2_11.png; $maysudo mv -f /usr/share/cinnamon/faces/2_11.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_12.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_12.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/2_13.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/2_13.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_lightning.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/lightning.jpg /usr/share/cinnamon/faces/3_lightning.jpg; $maysudo mv -f /usr/share/cinnamon/faces/3_lightning.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_mountain.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/3_mountain.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_sky.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/sky.jpg /usr/share/cinnamon/faces/3_sky.jpg; $maysudo mv -f /usr/share/cinnamon/faces/3_sky.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/3_sunset.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/sunset.jpg /usr/share/cinnamon/faces/3_sunset.jpg; $maysudo mv -f /usr/share/cinnamon/faces/3_sunset.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_cinnamon.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/4_cinnamon.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_flower.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/flower.jpg /usr/share/cinnamon/faces/4_flower.jpg; $maysudo mv -f /usr/share/cinnamon/faces/4_flower.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_leaf.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/leaf.jpg /usr/share/cinnamon/faces/4_leaf.jpg; $maysudo mv -f /usr/share/cinnamon/faces/4_leaf.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/4_sunflower.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/sunflower.jpg /usr/share/cinnamon/faces/4_sunflower.jpg; $maysudo mv -f /usr/share/cinnamon/faces/4_sunflower.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_fish.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/fish.jpg /usr/share/cinnamon/faces/5_fish.jpg; $maysudo mv -f /usr/share/cinnamon/faces/5_fish.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_kitten.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_kitten.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_penguin.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/penguin.jpg /usr/share/cinnamon/faces/5_penguin.jpg; $maysudo mv -f /usr/share/cinnamon/faces/5_penguin.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/5_puppy.jpg ]; then $maysudo mv -f /usr/share/cinnamon/faces/5_puppy.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_astronaut.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/astronaut.jpg /usr/share/cinnamon/faces/6_astronaut.jpg; $maysudo mv -f /usr/share/cinnamon/faces/6_astronaut.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_butterfly.png ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/butterfly.png /usr/share/cinnamon/faces/6_butterfly.png; $maysudo mv -f /usr/share/cinnamon/faces/6_butterfly.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_flake.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/flake.jpg /usr/share/cinnamon/faces/6_flake.jpg; $maysudo mv -f /usr/share/cinnamon/faces/6_flake.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/6_grapes.jpg ]; then $maysudo ln -sf /usr/share/pixmaps/faces/ubuntu/legacy/grapes.jpg /usr/share/cinnamon/faces/6_grapes.jpg; $maysudo mv -f /usr/share/cinnamon/faces/6_grapes.jpg /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_bat.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_bat.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_dog.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_dog.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_elephant.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_elephant.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_fox.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_fox.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_lion.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_lion.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_panda.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_panda.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_penguin.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_penguin.png /usr/share/cinnamon/faces/cinnamon; fi
if [ -f /usr/share/cinnamon/faces/7_tucan.png ]; then $maysudo mv -f /usr/share/cinnamon/faces/7_tucan.png /usr/share/cinnamon/faces/cinnamon; fi

echo "----------------------------------------------------------------------"
echo "DEBUG:"
echo "Script path: $rocketlaunch_dir" && echo "Current directory: $(pwd)"
echo "ls:" && ls
echo "----------------------------------------------------------------------"
tar -xzf Avatars.tar.gz
$maysudo rsync -av Avatars/. /usr/share/pixmaps/faces
$maysudo rm -rf Avatars
#-
$maysudo ln -sf ../../pixmaps/faces/1.png /usr/share/cinnamon/faces/1.png
$maysudo ln -sf ../../pixmaps/faces/2.png /usr/share/cinnamon/faces/2.png
$maysudo ln -sf ../../pixmaps/faces/3.png /usr/share/cinnamon/faces/3.png
$maysudo ln -sf ../../pixmaps/faces/4.png /usr/share/cinnamon/faces/4.png
$maysudo ln -sf ../../pixmaps/faces/5.png /usr/share/cinnamon/faces/5.png
$maysudo ln -sf ../../pixmaps/faces/6.png /usr/share/cinnamon/faces/6.png
$maysudo ln -sf ../../pixmaps/faces/7.png /usr/share/cinnamon/faces/7.png
$maysudo ln -sf ../../pixmaps/faces/8.png /usr/share/cinnamon/faces/8.png
$maysudo ln -sf ../../pixmaps/faces/9.png /usr/share/cinnamon/faces/9.png
$maysudo ln -sf ../../pixmaps/faces/10.png /usr/share/cinnamon/faces/10.png
$maysudo ln -sf ../../pixmaps/faces/11.png /usr/share/cinnamon/faces/11.png
$maysudo ln -sf ../../pixmaps/faces/12.png /usr/share/cinnamon/faces/12.png
$maysudo ln -sf ../../pixmaps/faces/13.png /usr/share/cinnamon/faces/13.png
$maysudo ln -sf ../../pixmaps/faces/14.png /usr/share/cinnamon/faces/14.png
$maysudo ln -sf ../../pixmaps/faces/15.png /usr/share/cinnamon/faces/15.png
$maysudo ln -sf ../../pixmaps/faces/16.png /usr/share/cinnamon/faces/16.png
$maysudo ln -sf ../../pixmaps/faces/17.png /usr/share/cinnamon/faces/17.png
$maysudo ln -sf ../../pixmaps/faces/18.png /usr/share/cinnamon/faces/18.png
$maysudo ln -sf ../../pixmaps/faces/19.png /usr/share/cinnamon/faces/19.png
$maysudo ln -sf ../../pixmaps/faces/user-generic.png /usr/share/cinnamon/faces/user-generic.png
