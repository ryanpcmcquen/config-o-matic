#!/bin/sh

# wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig14.1ROOT.sh; sh slackConfig14.1ROOT.sh; rm slackConfig14.1ROOT.sh

## BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimROOT.sh"

## set config files here:
SBOPKGDL="http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz"
SPPLUSDL="http://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.3.1-noarch-4mt.txz"
SPPLUSCONF64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/14.1/slackpkgplus.conf"
SPPLUSCONF32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/14.1/slackpkgplus.conf"

INSCRPT="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/initscript"

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

GITNAME="Ryan Q"
GITEMAIL="ryan.q@linux.com"

TOUCHPCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/51-synaptics.conf"


CALPLAS="Caledonia-1.6.2.tar.gz"
CALWALL="Caledonia_Official_Wallpaper_Collection-1.5.tar.gz"


if [ ! $UID = 0 ]; then
  cat << EOF

This script must be run as root.

EOF
  exit 1
fi


read -r -p "Would you like to become NEARFREE? \
(follows freeslack.net, but keeps kernel, not valid with other options) \
[y/N]: " response
case $response in
  [yY][eE][sS]|[yY])
    export NEARFREE=true;
    echo You are becoming NEARFREE.;
    ;;
  *)
    echo You are not becoming NEARFREE.;
    ;;
esac


if [ "$NEARFREE" != true ]; then
  read -r -p "Would you like to go VANILLA? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export VANILLA=true;
      echo You are going VANILLA.;
      ;;
    *)
      echo You are not going VANILLA.;
      ;;
  esac
fi


if [ "$NEARFREE" != true ]; then
  read -r -p "Would you like to install Mate? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export MATE=true;
      echo You have chosen to install Mate.;
      ;;
    *)
      echo You are not installing Mate.;
      ;;
  esac
fi


wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/

wget -N $VIMRC -P ~/


## set tmux scrollback value
tmux set-option -g history-limit 9999


## configure lilo
sed -i 's/^#compact/lba32\
compact/g' /etc/lilo.conf

## set to utf8 console if not set in install
sed -i 's/^append=" vt.default_utf8=0"/append=" vt.default_utf8=1"/g' /etc/lilo.conf

sed -i 's/^timeout = 50/timeout = 5/g' /etc/lilo.conf
sed -i 's/^timeout = 1200/timeout = 5/g' /etc/lilo.conf

lilo

## change to utf-8 encoding
sed -i 's/^export LANG=en_US/#export LANG=en_US/g' /etc/profile.d/lang.sh
sed -i 's/^#export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g' /etc/profile.d/lang.sh

sed -i 's/#\[0-9]+_SBo/\
\[0-9]+_SBo\
sbopkg/g' /etc/slackpkg/blacklist


### undo current
sed -i 's_^http://ftp.osuosl.org/.2/slackware/slackware-current/_# http://ftp.osuosl.org/.2/slackware/slackware-current/_g' /etc/slackpkg/mirrors
sed -i 's_^http://ftp.osuosl.org/.2/slackware/slackware64-current/_# http://ftp.osuosl.org/.2/slackware/slackware64-current/_g' /etc/slackpkg/mirrors
### osuosl mirrors are stable and fast (they are used for the changelogs), choose mirrorbrain if you are far from oregon
sed -i 's_^# http://ftp.osuosl.org/.2/slackware/slackware-14.1/_http://ftp.osuosl.org/.2/slackware/slackware-14.1/_g' /etc/slackpkg/mirrors
sed -i 's_^# http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_g' /etc/slackpkg/mirrors


## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"


wget -N $TOUCHPCONF -P /etc/X11/xorg.conf.d/

wget -N $SBOPKGDL -P ~/
if [ "$NEARFREE" != true ]; then
  wget -N $SPPLUSDL -P ~/
fi

installpkg ~/*.t?z

rm ~/*.t?z

wget -N $INSCRPT -P /etc/

if [ "$( uname -m )" = "x86_64" ] && [ "$NEARFREE" != true ]; then
  if [ "$MATE" = true ]; then
    wget -N $SPPLUSCONF64 -P /etc/slackpkg/
  fi
elif [ "$MATE" = true ] && [ "$NEARFREE" != true ]; then
  wget -N $SPPLUSCONF32 -P /etc/slackpkg/
fi

if [ "$NEARFREE" = true ]; then
  removepkg getty-ps lha unarj zoo amp \
  bluez-firmware ipw2100-fw ipw2200-fw trn \
  zd1211-firmware xfractint xgames xv

  ## set slackpkg to non-interactive mode to run without prompting
  sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf

  slackpkg blacklist getty-ps lha unarj zoo amp \
  bluez-firmware ipw2100-fw ipw2200-fw trn \
  zd1211-firmware xfractint xgames xv

  echo "You have become NEARFREE, to update your kernel, head to freeslack.net."

elif [ "$VANILLA" = true ]; then
  echo "You have gone VANILLA."
else
  ## set slackpkg to non-interactive mode to run without prompting
  sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf

  slackpkg update gpg && \
  slackpkg update

  slackpkg install wicd ffmpeg vlc chromium

  slackpkg install-new && \
  slackpkg upgrade-all

  chmod -x /etc/rc.d/rc.networkmanager
  sed -i 's/^\([^#]\)/#\1/g' /etc/rc.d/rc.inet1.conf
  sed -i 's/^\([^#]\)/#\1/g' /etc/rc.d/rc.wireless.conf

  ## ntp cron job (the bad way)
  #wget -N https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/clocksync -P /etc/cron.daily/

  ## set up ntp daemon (the good way)
  /etc/rc.d/rc.ntpd stop
  ntpdate 0.pool.ntp.org
  ntpdate 1.pool.ntp.org
  hwclock --systohc
  sed -i 's/#server pool.ntp.org iburst / \
  server 0.pool.ntp.org iburst \
  server 1.pool.ntp.org iburst \
  server 2.pool.ntp.org iburst \
  server 3.pool.ntp.org iburst \
  /g' /etc/ntp.conf
  chmod +x /etc/rc.d/rc.ntpd
  /etc/rc.d/rc.ntpd start

  ## create sbopkg directories
  mkdir -pv /var/lib/sbopkg/SBo/14.1/
  mkdir -pv /var/lib/sbopkg/queues/
  mkdir -pv /var/log/sbopkg/
  mkdir -pv /var/cache/sbopkg/
  mkdir -pv /tmp/SBo/
  ## reverse
  #rm -rfv /var/lib/sbopkg/
  #rm -rfv /var/log/sbopkg/
  #rm -rfv /var/cache/sbopkg/
  #rm -rfv /tmp/SBo/
  ## check for sbopkg update,
  ## then sync the slackbuilds.org repo
  sbopkg -B -u
  sbopkg -B -r

  if [ -z "$( ls /var/log/packages/ | grep superkey-launch )" ]; then
    sbopkg -B -i superkey-launch
  fi

  ## this library is necessary for some games,
  ## doesn't hurt to have it  ; ^)
  if [ -z "$( ls /var/log/packages/ | grep libtxc_dxtn )" ]; then
    sbopkg -B -i libtxc_dxtn
  fi

  if [ -z "$( ls /var/log/packages/ | grep OpenAL )" ]; then
    sbopkg -B -i OpenAL
  fi

  if [ -z "$( ls /var/log/packages/ | grep roxterm )" ]; then
    sbopkg -B -i roxterm
  fi

  if [ -z "$( ls /var/log/packages/ | grep dwm )" ]; then
    sbopkg -B -i dwm
  fi

  if [ -z "$( ls /var/log/packages/ | grep dmenu )" ]; then
    sbopkg -B -i dmenu
  fi

  ## file syncing service
  if [ -z "$( ls /var/log/packages/ | grep copy )" ]; then
    sbopkg -B -i copy
  fi

  ## because QtCurve looks amazing
  if [ ! -z "$( ls /var/log/packages/ | grep kdelibs )" ]; then
    if [ -z "$( ls /var/log/packages/ | grep QtCurve-KDE4 )" ]; then
      sbopkg -B -i QtCurve-KDE4
    fi
  fi

  if [ -z "$( ls /var/log/packages/ | grep QtCurve-Gtk2 )" ]; then
    sbopkg -B -i QtCurve-Gtk2
  fi

  ## numix stuff is dead sexy
  git clone https://github.com/numixproject/numix-icon-theme.git
  mv ./numix-icon-theme/Numix/ /usr/share/icons/
  rm -rf ./numix-icon-theme/

  git clone https://github.com/numixproject/numix-icon-theme-bevel.git
  mv ./numix-icon-theme-bevel/Numix-Bevel/ /usr/share/icons/
  rm -rf ./numix-icon-theme-bevel/

  git clone https://github.com/numixproject/numix-icon-theme-circle.git
  mv ./numix-icon-theme-circle/Numix-Circle/ /usr/share/icons/
  rm -rf ./numix-icon-theme-circle/

  git clone https://github.com/numixproject/numix-icon-theme-shine.git
  mv ./numix-icon-theme-shine/Numix-Shine/ /usr/share/icons/
  rm -rf ./numix-icon-theme-shine/

  git clone https://github.com/numixproject/numix-icon-theme-utouch.git
  mv ./numix-icon-theme-utouch/Numix-uTouch/ /usr/share/icons/
  rm -rf ./numix-icon-theme-utouch/

  git clone https://github.com/shimmerproject/Numix.git
  mv ./Numix/ /usr/share/themes/
  rm -rf ./Numix/

  wget -N https://raw.githubusercontent.com/numixproject/numix-kde-theme/master/Numix.colors -P /usr/share/apps/color-schemes/
  mv /usr/share/apps/color-schemes/Numix.colors /usr/share/apps/color-schemes/Numix-KDE.colors
  wget -N https://raw.githubusercontent.com/numixproject/numix-kde-theme/master/Numix.qtcurve -P /usr/share/apps/QtCurve/
  mv /usr/share/apps/QtCurve/Numix.qtcurve /usr/share/apps/QtCurve/Numix-KDE.qtcurve

  ## caledonia kde theme
  wget -N http://sourceforge.net/projects/caledonia/files/Caledonia%20%28Plasma-KDE%20Theme%29/$CALPLAS -P ~/
  tar xf ~/$CALPLAS -C /usr/share/apps/desktoptheme/
  rm ~/$CALPLAS

  ## get caledonia wallpapers, who doesn't like nice wallpapers?
  wget -N http://sourceforge.net/projects/caledonia/files/Caledonia%20Official%20Wallpapers/$CALWALL -P ~/
  tar xf ~/$CALWALL
  cp -r ~/Caledonia_Official_Wallpaper_Collection/* /usr/share/wallpapers/
  rm -rf ~/Caledonia_Official_Wallpaper_Collection/
  rm ~/$CALWALL

  ## a few numix wallpapers also
  wget -N http://fc03.deviantart.net/fs71/f/2013/305/3/6/numix___halloween___wallpaper_by_satya164-d6skv0g.zip -P ~/
  wget -N http://fc00.deviantart.net/fs70/f/2013/249/7/6/numix___fragmented_space_by_me4oslav-d6l8ihd.zip -P ~/
  wget -N http://fc09.deviantart.net/fs70/f/2013/224/b/6/numix___name_of_the_doctor___wallpaper_by_satya164-d6hvzh7.zip -P ~/
  unzip numix___halloween___wallpaper_by_satya164-d6skv0g.zip
  unzip numix___fragmented_space_by_me4oslav-d6l8ihd.zip
  unzip numix___name_of_the_doctor___wallpaper_by_satya164-d6hvzh7.zip
  rm numix___halloween___wallpaper_by_satya164-d6skv0g.zip
  rm numix___fragmented_space_by_me4oslav-d6l8ihd.zip
  rm numix___name_of_the_doctor___wallpaper_by_satya164-d6hvzh7.zip

  cp ~/*.png /usr/share/wallpapers/
  #cp ~/*.png /usr/share/backgrounds/
  cp ~/*.jpg /usr/share/wallpapers/
  #cp ~/*.jpg /usr/share/backgrounds/
  rm ~/*.jpg
  rm ~/*.png

fi


if [ "$MATE" = true ] && [ "$NEARFREE" != true ]; then
  slackpkg install msb
fi


## set slackpkg back to normal
sed -i 's/^BATCH=on/BATCH=off/g' /etc/slackpkg/slackpkg.conf
sed -i 's/^DEFAULT_ANSWER=y/DEFAULT_ANSWER=n/g' /etc/slackpkg/slackpkg.conf

echo
echo
echo "************************************"
echo "********** CONFIG-O-MATIC **********"
echo "************************************"
echo
echo "Your system is now set to UTF-8."
echo "(e.g. You should use uxterm, instead of xterm)."
echo "Thank you for using config-o-matic!"
echo "You should now run 'adduser', if you have not."
echo "Then you should run the $ user script."
echo


