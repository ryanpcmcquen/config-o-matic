#!/bin/sh

# curl https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackFluxConfig$.sh | bash

#### set your global config files & variables here:
###$BASHGITVIM="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

$BASHRC="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
$BASHPR="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"
$GITCONF="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/.gitconfig"
$VIMRC="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
$FLUXBOXCONF="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"

if [ ! $UID != 0 ]; then
cat << EOF

This script must not be run as root.

EOF
  exit 1
fi

mkdir -p ~/.vim/tmp

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/
wget -N $GITCONF -P ~/
wget -N $VIMRC -P ~/

#### you can use this if you have a file that configures all 3
###curl $BASHGITVIM | bash

curl $FLUXBOXCONF | bash

## numix theme
#wget -N http://box-look.org/CONTENT/content-files/159716-numixpeg.tar.gz -P ~/
#tar xf ~/159716-numixpeg.tar.gz -C ~/.fluxbox/styles
#echo "session.styleFile: /home/ry/.fluxbox/styles/numixpeg" >> ~/.fluxbox/init

## just dark theme
#wget -N http://box-look.org/CONTENT/content-files/163116-Just.tgz -P ~/
#tar xf ~/163116-Just.tgz -C ~/.fluxbox/styles
#echo "session.styleFile: /home/ry/.fluxbox/styles/Just" >> ~/.fluxbox/init
#rm ~/163116-Just.tgz

## dyne theme
wget -N http://box-look.org/CONTENT/content-files/61999-Dyne-fluxbox.tar.gz -P ~/
tar xf ~/61999-Dyne-fluxbox.tar.gz -C ~/.fluxbox/styles
echo "session.styleFile: /home/ry/.fluxbox/styles/Dyne" >> ~/.fluxbox/init

rm ~/61999-Dyne-fluxbox.tar.gz

