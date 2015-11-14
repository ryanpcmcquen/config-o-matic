#!/bin/sh

# cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/.slackConfig%24.sh -P ~/; sh ~/.slackConfig\$.sh

### BASHGITVIM="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/bashGitVimNORMAL.sh"

#### set your config files here:

BASHRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
VIMCOLOR="https://raw.githubusercontent.com/ryanpcmcquen/true-monochrome_vim/master/colors/true-monochrome.vim"

XBINDKEYSRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.xbindkeysrc"

FLUXBOXCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/restoreFluxbox.sh"
WMAKERCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/windowmakerSetup.sh"
PEKWMCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/pekwmSetup.sh"
LUMINACONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/luminaSetup.sh"

GKRELLCFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/user-config"
GKRELLTFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/theme_config"
GKRELLCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/gkrellmConfig.sh"

KDECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/kdeSetup.sh"

XFCECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/xfceSetup.sh"

MATECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/mateSetup.sh"

BRACKETSCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/brackets.json"
ZEDCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.config/zed/config/user.json"

GITNAME="Ryan P.C. McQuen"
GITEMAIL="ryan.q@linux.com"


if [ $UID = 0 ]; then
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

## fixes some gsettings/dconf/xfconf errors
DBUS_SESSION_FILE=~/.dbus/session-bus/$(cat /var/lib/dbus/machine-id)-0
if [ -e "$DBUS_SESSION_FILE" ]; then
  . "$DBUS_SESSION_FILE"
  export DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID
fi

xdg-mime default mozilla-firefox.desktop x-scheme-handler/http
xdg-mime default mozilla-firefox.desktop x-scheme-handler/https
xdg-mime default mozilla-thunderbird.desktop x-scheme-handler/mailto

gkrellm &

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

wget -N $VIMRC -P ~/
mkdir -pv ~/.vim/colors/
wget -N $VIMCOLOR -P ~/.vim/colors/

## makes keyboard shortcuts easy
## while maintaining minimalism
wget -N $XBINDKEYSRC -P ~/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"

#### you can use this if you have a file that configures all 3
### curl $BASHGITVIM | sh

wget -N $GKRELLCFIL -P ~/.gkrellm2/
wget -N $GKRELLTFIL -P ~/.gkrellm2/
curl $GKRELLCONF | sh

pkill gkrellm &

## fluxbox
if [ -d ~/.fluxbox ]; then
  curl $FLUXBOXCONF | sh
fi

## window maker
if [ -d ~/GNUstep ]; then
  curl $WMAKERCONF | sh
fi

## pekwm
if [ -d ~/.pekwm ]; then
  curl $PEKWMCONF | sh
fi

## lumina
if [ -d ~/.lumina ]; then
  curl $LUMINACONF | sh
fi

## kde
if [ "`find /var/log/packages/ -name kdelibs-*`" ]; then
  curl $KDECONF | sh
fi

## mate
if [ "`find /var/log/packages/ -name pluma-*`" ]; then
  curl $MATECONF | sh
fi

## xfce
if [ "`find /var/log/packages/ -name Thunar-*`" ]; then
  curl $XFCECONF | sh
fi

## e16
if [ -d /usr/share/e16 ]; then
  if [ -e ~/.e16/e_config--0.0.cfg ]; then
    if [ -z "$(cat ~/.e16/e_config--0.0.cfg | grep 'focus.all_new_windows_get_focus')" ]; then
      echo "focus.all_new_windows_get_focus = 1" >> ~/.e16/e_config--0.0.cfg
    else
      sed -i.bak 's/focus.all_new_windows_get_focus = 0/focus.all_new_windows_get_focus = 1/g' ~/.e16/e_config--0.0.cfg
    fi
  fi
fi

## beautiful minimalism
mkdir -pv ~/.icons/
if [ ! -e ~/.icons/default ]; then
  if [ -d "/usr/share/icons/Oxygen_Zion/" ]; then
    ln -sfv /usr/share/icons/Oxygen_Zion/ ~/.icons/default
  else
    ln -sfv /usr/share/icons/nuvola/ ~/.icons/default
  fi
fi

## make copyagent launch at startup in some environments
if [ -e /usr/share/applications/CopyAgent.desktop ]; then
  mkdir -pv ~/.config/autostart/
  ln -sfv /usr/share/applications/CopyAgent.desktop ~/.config/autostart/
fi

## fixes kde firefox icon
rm -v ~/.local/share/applications/userapp-Firefox-*.desktop

## brackets config [2 spaces!]
wget -N $BRACKETSCONF -P ~/.config/Brackets/

## zed (2 spaces, and trim whitespace)
wget -N $ZEDCONF -P ~/.config/zed/config/

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

