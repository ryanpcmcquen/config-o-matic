#!/bin/sh

# cd; curl https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackConfig$.sh | sh

### BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

#### set your config files here:

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

FLUXBOXCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"

GKRELLCFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/user-config"
GKRELLCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/gkrellmConfig.sh"

KDECONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/kdeSetup.sh"

XFCECONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/xfceSetup.sh"

MATECONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/mateSetup.sh"

GITNAME="Ryan P.C. McQuen"
GITEMAIL="ryan.q@linux.com"


if [ ! $UID != 0 ]; then
cat << EOF

This script must not be run as root.

EOF
  exit 1
fi


echo
echo
echo "*************************************************************"
echo "*************************************************************"
echo "********          WELCOME TO                         ********"
echo "********              CONFIG-O-MATIC                 ********"
echo "*************************************************************"
echo "*************************************************************"
echo
echo

## not really necessary, but maybe someday  ;-)
cd


gkrellm &

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

wget -N $VIMRC -P ~/


## set tmux scrollback value
tmux set-option -g history-limit 9999
## set to xterm otherwise vi will break
tmux set-option -g default-terminal xterm-color


## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"


#### you can use this if you have a file that configures all 3
### curl $BASHGITVIM | sh


wget -N $GKRELLCFIL -P ~/.gkrellm2/
curl $GKRELLCONF | sh

if [ ! -z "$( ls -a ~/ | grep .fluxbox )" ]; then
  curl $FLUXBOXCONF | sh
fi

if [ ! -z "$( ls /var/log/packages/ | grep kdelibs )" ]; then
  curl $KDECONF | sh
fi

if [ ! -z "$( ls /var/log/packages/ | grep Thunar )" ]; then
  curl $XFCECONF | sh
fi

if [ ! -z "$( ls /var/log/packages/ | grep pluma )" ]; then
  curl $MATECONF | sh
fi


rm ~/.local/share/applications/userapp-Firefox-*.desktop

if [ ! -z "$( ls /var/log/packages/ | grep superkey-launch )" ]; then
  superkey-launch &
fi


echo
echo
echo "************************************"
echo "********** CONFIG-O-MATIC **********"
echo "************************************"
echo
echo "Thank you for using config-o-matic!"
echo
echo "You should now reboot."
echo

