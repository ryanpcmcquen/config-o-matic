#!/bin/sh

# cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/.slackConfig%24.sh -P ~/; sh ~/.slackConfig\$.sh

#### set your config files here:

BASHRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bashrc"
BASHPR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/normal/.bash_profile"

VIMRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
##VIMCOLOR="https://raw.githubusercontent.com/ryanpcmcquen/true-monochrome_vim/master/colors/true-monochrome.vim"

SCITECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.SciTEUser.properties"

XBINDKEYSRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.xbindkeysrc"

FLUXBOXCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.restoreFluxbox.sh"
WMAKERCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.windowmakerSetup.sh"
PEKWMCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.pekwmSetup.sh"
LUMINACONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.luminaSetup.sh"
KDECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.kdeSetup.sh"
XFCECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.xfceSetup.sh"
MATECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.mateSetup.sh"

GKRELLCFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/user-config"
GKRELLTFIL="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/gkrellm2/theme_config"
GKRELLCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.gkrellmConfig.sh"

BRACKETSCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/brackets.json"
ZEDCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.config/zed/config/user.json"

GITNAME="Ryan P.C. McQuen"
GITEMAIL="ryan.q@linux.com"

save_and_execute() {
  for ITEM in "$@"; do
    wget -N $ITEM -P ~/
    sh ~/`basename $ITEM`
  done
}

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

## These directories have to be created by launching the applications.
if [ ! -d ~/.gkrellm2/ ]; then
  gkrellm &
  pkill gkrellm &
fi

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

wget -N $VIMRC -P ~/
## i just include my theme in my .vimrc
##mkdir -pv ~/.vim/colors/
##wget -N $VIMCOLOR -P ~/.vim/colors/

## makes keyboard shortcuts easy
## while maintaining minimalism
wget -N $XBINDKEYSRC -P ~/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"

wget -N $GKRELLCFIL -P ~/.gkrellm2/
wget -N $GKRELLTFIL -P ~/.gkrellm2/
save_and_execute $GKRELLCONF

## fluxbox
if [ -d ~/.fluxbox ]; then
  save_and_execute $FLUXBOXCONF
fi

## window maker
if [ -d ~/GNUstep ]; then
  save_and_execute $WMAKERCONF
fi

## pekwm
if [ -d ~/.pekwm ]; then
  save_and_execute $PEKWMCONF
fi

## lumina
if [ -d ~/.lumina ]; then
  save_and_execute $LUMINACONF
fi

## kde
if [ "`find /var/log/packages/ -name kdelibs-*`" ]; then
  save_and_execute $KDECONF
fi

## mate
if [ "`find /var/log/packages/ -name pluma-*`" ]; then
  save_and_execute $MATECONF
fi

## xfce
if [ "`find /var/log/packages/ -name Thunar-*`" ]; then
  save_and_execute $XFCECONF
fi

## e16
if [ -d /usr/share/e16 ]; then
  if [ -e ~/.e16/e_config--0.0.cfg ]; then
    if [ -z "$(grep 'focus.all_new_windows_get_focus' ~/.e16/e_config--0.0.cfg)" ]; then
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

## fixes kde firefox icon
rm -v ~/.local/share/applications/userapp-Firefox-*.desktop

## brackets config [2 spaces!]
wget -N $BRACKETSCONF -P ~/.config/Brackets/

## zed (2 spaces, and trim whitespace)
wget -N $ZEDCONF -P ~/.config/zed/config/

## scite!
wget -N $SCITECONF \
  -P ~/

## atom goodies
[ `which atom` ] && apm install atom-beautify language-diff language-haskell language-lua \
  && wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.jsbeautifyrc -P ~/

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

