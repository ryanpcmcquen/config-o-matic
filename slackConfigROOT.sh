#!/bin/sh

# wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

## BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimROOT.sh"

## set config files here:
SBOPKGDL="http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz"
SPPLUSDL="http://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.3.2-noarch-1mt.txz"

## STABLE
SPPLUSSTA64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/14.1/slackpkgplus.conf"
SPPLUSMATESTA64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/14.1/mate/slackpkgplus.conf"
SPPLUSMLIBSTA64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/14.1/multilib/slackpkgplus.conf"

## CURRENT
SPPLUSCUR64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/current/slackpkgplus.conf"
SPPLUSMATECUR64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/current/mate/slackpkgplus.conf"
SPPLUSMLIBCUR64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/current/multilib/slackpkgplus.conf"

## STABLE
SPPLUSMATESTA32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/14.1/mate/slackpkgplus.conf"
SPPLUSSTA32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/14.1/slackpkgplus.conf"

## CURRENT
SPPLUSCUR32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/current/slackpkgplus.conf"
SPPLUSMATECUR32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/current/mate/slackpkgplus.conf"

INSCRPT="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/initscript"

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

GITNAME="Ryan P.C. McQuen"
GITEMAIL="ryan.q@linux.com"

TOUCHPCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/51-synaptics.conf"

GETEXTRASTA="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/getExtraSlackBuildsSTABLE.sh"
GETEXTRACUR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/getExtraSlackBuildsCURRENT.sh"

CALPLAS="Caledonia-1.9.tar.gz"
CALWALL="Caledonia_Official_Wallpaper_Collection-1.5.tar.gz"

## eric hameleers has updated multilib to include this package
#LIBXSHM="libxshmfence-1.1-i486-1.txz"

if [ ! $UID = 0 ]; then
  cat << EOF
This script must be run as root.
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

## make sure we are home  ;^)
cd


read -r -p "Do you need a .ASOUNDRC? \
(usually comps with HDMI ports do, you can always 'rm ~/.asoundrc' if sound breaks) \
[y/N]: " response
case $response in
  [yY][eE][sS]|[yY])
    export ASOUNDRC=true;
    echo You are installing ~/.asoundrc;
    ;;
  *)
    echo You are not installing ~/.asoundrc;
    ;;
esac
if [ "$ASOUNDRC" = true ]; then
  wget -N https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/.asoundrc -P ~/
fi


read -r -p "Would you like to switch to -CURRENT? \
(if no you will stay on STABLE) \
[y/N]: " response
case $response in
  [yY][eE][sS]|[yY])
    export CURRENT=true;
    echo You are switching to -CURRENT.;
    ;;
  *)
    echo You are going STABLE.;
    ;;
esac

read -r -p "Would you like to install WICD? \
(NetworkManager will be disabled, and you may need to manually adjust \
autostart settings) \
 [y/N]: " response
case $response in
  [yY][eE][sS]|[yY])
    export WICD=true;
    echo You are installing WICD.;
    ;;
  *)
    echo You are not installing WICD.;
    ;;
esac

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
  read -r -p "Would you like to install additional packages, themes and MISCELLANY? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export MISCELLANY=true;
      echo You are installing MISCELLANY.;
      ;;
    *)
      echo You are going VANILLA.;
      ;;
  esac
fi

if [ "$NEARFREE" != true ]; then
  read -r -p "Would you like to install MATE? (choose no if you want MULTILIB) [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export MATE=true;
      echo You have chosen to install MATE.;
      ;;
    *)
      echo You are not installing MATE.;
      ;;
  esac
fi

if [ "$NEARFREE" != true ] && [ "$MATE" != true ] && [ "$( uname -m )" = "x86_64" ]; then
  read -r -p "Would you like to go MULTILIB? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export MULTILIB=true;
      echo You have chosen to go MULTILIB.;
      ;;
    *)
      echo You are not going MULTILIB.;
      ;;
  esac
fi

if [ "$NEARFREE" != true ]; then
  read -r -p "Would you like to install additional SCRIPTS? [y/N]: " response
  case $response in
    [yY][eE][sS]|[yY])
      export SCRIPTS=true;
      echo You have chosen to install additional SCRIPTS.;
      ;;
    *)
      echo You are not installing additional SCRIPTS.;
      ;;
  esac
fi


## configure lilo
sed -i 's/^#compact/lba32\
compact/g' /etc/lilo.conf

### set to utf8 console if not set in install
### no longer needed with below command
##sed -i 's/^append=" vt.default_utf8=0"/append=" vt.default_utf8=1"/g' /etc/lilo.conf

## set to utf8 and pass acpi kernel params
## these fix brightness key issues on some comps
## and have no negative effects on others (in my testing at least)
sed -i 's/^append=" vt.default_utf8=[0-9]"/append=" vt.default_utf8=1 acpi_osi=linux acpi_backlight=vendor"/g' /etc/lilo.conf

sed -i 's/^timeout = 50/timeout = 5/g' /etc/lilo.conf
sed -i 's/^timeout = 1200/timeout = 5/g' /etc/lilo.conf

lilo

## change to utf-8 encoding
sed -i 's/^export LANG=en_US/#export LANG=en_US/g' /etc/profile.d/lang.sh
sed -i 's/^#export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g' /etc/profile.d/lang.sh

if [ "$CURRENT" = true ]; then
  ## adjust slackpkg blacklist
  sed -i 's/^aaa_elflibs/#aaa_elflibs/g' /etc/slackpkg/blacklist
fi

sed -i 's/#\[0-9]+_SBo/\
\[0-9]+_SBo\
sbopkg/g' /etc/slackpkg/blacklist

if [ "$CURRENT" = true ]; then
  ### undo 14.1 mirrors
  sed -i \
  's_^http://ftp.osuosl.org/.2/slackware/slackware-14.1/_# http://ftp.osuosl.org/.2/slackware/slackware-14.1/_g' /etc/slackpkg/mirrors
  sed -i \
  's_^http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_# http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_g' /etc/slackpkg/mirrors
  ### osuosl mirrors are stable and fast (they are used for the changelogs), choose mirrorbrain if you are far from oregon
  sed -i \
  's_^# http://ftp.osuosl.org/.2/slackware/slackware-current/_http://ftp.osuosl.org/.2/slackware/slackware-current/_g' /etc/slackpkg/mirrors
  sed -i \
  's_^# http://ftp.osuosl.org/.2/slackware/slackware64-current/_http://ftp.osuosl.org/.2/slackware/slackware64-current/_g' /etc/slackpkg/mirrors
else
  ### undo current
  sed -i \
  's_^http://ftp.osuosl.org/.2/slackware/slackware-current/_# http://ftp.osuosl.org/.2/slackware/slackware-current/_g' /etc/slackpkg/mirrors
  sed -i \
  's_^http://ftp.osuosl.org/.2/slackware/slackware64-current/_# http://ftp.osuosl.org/.2/slackware/slackware64-current/_g' /etc/slackpkg/mirrors
  ### osuosl mirrors are stable and fast (they are used for the changelogs), choose mirrorbrain if you are far from oregon
  sed -i \
  's_^# http://ftp.osuosl.org/.2/slackware/slackware-14.1/_http://ftp.osuosl.org/.2/slackware/slackware-14.1/_g' /etc/slackpkg/mirrors
  sed -i \
  's_^# http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_http://ftp.osuosl.org/.2/slackware/slackware64-14.1/_g' /etc/slackpkg/mirrors
fi

wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/
wget -N $VIMRC -P ~/

wget -N $TOUCHPCONF -P /etc/X11/xorg.conf.d/
wget -N $INSCRPT -P /etc/

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

## sbo git hooks
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sbo/hooks/commit-msg \
  -P /usr/share/git-core/templates/hooks/
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sbo/hooks/pre-commit \
  -P /usr/share/git-core/templates/hooks/
  ## this is just in case permissions are incorrect,
  ## these files should already be 755  ;^)
  chmod 755 /usr/share/git-core/templates/hooks/*

wget -N $SBOPKGDL -P ~/
if [ "$NEARFREE" != true ]; then
  wget -N $SPPLUSDL -P ~/
fi
installpkg ~/*.t?z
cp /etc/slackpkg/slackpkgplus.conf /etc/slackpkg/slackpkgplus.conf.old
rm ~/*.t?z

## set slackpkg to non-interactive mode to run without prompting
sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf

if [ "$NEARFREE" != true ] && [ "$CURRENT" = true ]; then
  if [ "$( uname -m )" = "x86_64" ]; then
    if [ "$MATE" = true ]; then
      wget -N $SPPLUSMATECUR64 -P /etc/slackpkg/
    elif [ "$MULTILIB" = true ]; then
      wget -N $SPPLUSMLIBCUR64 -P /etc/slackpkg/
    elif [ "$MATE" != true ] && [ "$MULTILIB" != true ] && [ "$MISCELLANY" = true ]; then
      wget -N $SPPLUSCUR64 -P /etc/slackpkg/
    fi
  elif [ "$MATE" = true ]; then
    wget -N $SPPLUSMATECUR32 -P /etc/slackpkg/
  elif [ "$MATE" != true ] && [ "$MISCELLANY" = true ]; then
    wget -N $SPPLUSCUR32 -P /etc/slackpkg/
  fi
elif [ "$NEARFREE" != true ]; then
  if [ "$( uname -m )" = "x86_64" ]; then
    if [ "$MATE" = true ]; then
      wget -N $SPPLUSMATESTA64 -P /etc/slackpkg/
    elif [ "$MULTILIB" = true ]; then
      wget -N $SPPLUSMLIBSTA64 -P /etc/slackpkg/
    elif [ "$MATE" != true ] && [ "$MULTILIB" != true ] && [ "$MISCELLANY" = true ]; then
      wget -N $SPPLUSSTA64 -P /etc/slackpkg/
    fi
  elif [ "$MATE" = true ]; then
    wget -N $SPPLUSMATESTA32 -P /etc/slackpkg/
  elif [ "$MATE" != true ] && [ "$MISCELLANY" = true ]; then
    wget -N $SPPLUSSTA32 -P /etc/slackpkg/
  fi
fi

if [ "$NEARFREE" = true ]; then
  removepkg getty-ps lha unarj zoo amp \
  bluez-firmware ipw2100-fw ipw2200-fw trn \
  zd1211-firmware xfractint xgames xv

  slackpkg blacklist getty-ps lha unarj zoo amp \
  bluez-firmware ipw2100-fw ipw2200-fw trn \
  zd1211-firmware xfractint xgames xv

  echo "You have become NEARFREE, to update your kernel, head to freeslack.net."
elif [ "$MISCELLANY" = true ]; then
  ## this prevents breakage if slackpkg gets updated
  slackpkg update gpg && slackpkg update
  slackpkg install-new && slackpkg upgrade-all

  ## set slackpkg to non-interactive mode to run without prompting
  ## we set again just in case someone overwrites configs
  sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf
  slackpkg update gpg && slackpkg update
  slackpkg install vlc chromium

  ## eric hameleers has updated multilib to include this package
  #  if [ "$( uname -m )" = "x86_64" ]; then
  #    wget -N http://mirrors.slackware.com/slackware/slackware-current/slackware/x/$LIBXSHM -P ~/
  #    installpkg ~/$LIBXSHM
  #    rm ~/$LIBXSHM
  #    slackpkg blacklist libxshmfence
  #  fi

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

  if [ -z "$( ls /var/log/packages/ | grep imlib2 )" ]; then
    sbopkg -B -i imlib2
  fi

  if [ -z "$( ls /var/log/packages/ | grep giblib )" ]; then
    sbopkg -B -i giblib
  fi

  if [ -z "$( ls /var/log/packages/ | grep scrot )" ]; then
    sbopkg -B -i scrot
  fi

  if [ -z "$( ls /var/log/packages/ | grep screenfetch )" ]; then
    sbopkg -B -i screenfetch
  fi

  ## this library is necessary for some games,
  ## doesn't hurt to have it  ; ^)
  if [ -z "$( ls /var/log/packages/ | grep libtxc_dxtn )" ]; then
    sbopkg -B -i libtxc_dxtn
  fi

  if [ -z "$( ls /var/log/packages/ | grep lxterminal )" ]; then
    sbopkg -B -i lxterminal
  fi

  ## this is a decent replacement for lxterminal,
  ## which was not compiling on current for a while ...
  ## but lxterminal is better
  #if [ -z "$( ls /var/log/packages/ | grep tinyterm )" ]; then
  #  sbopkg -B -i tinyterm
  #fi

  if [ -z "$( ls /var/log/packages/ | grep lame )" ]; then
    sbopkg -B -i lame
  fi

  if [ -z "$( ls /var/log/packages/ | grep x264 )" ]; then
    sbopkg -B -i x264
  fi

  if [ -z "$( ls /var/log/packages/ | grep ffmpeg )" ]; then
    sbopkg -B -i ffmpeg
  fi

  if [ -z "$( ls /var/log/packages/ | grep OpenAL )" ]; then
    sbopkg -B -i OpenAL
  fi

  if [ -z "$( ls /var/log/packages/ | grep SDL_gfx )" ]; then
    sbopkg -B -i SDL_gfx
  fi

  if [ -z "$( ls /var/log/packages/ | grep SDL_sound )" ]; then
    sbopkg -B -i SDL_sound
  fi

  ## doesn't compile on current
  #if [ -z "$( ls /var/log/packages/ | grep SDL_Pango )" ]; then
  #  sbopkg -B -i SDL_Pango
  #fi

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

  if [ -z "$( ls /var/log/packages/ | grep murrine )" ]; then
    sbopkg -B -i murrine
  fi

  if [ -z "$( ls /var/log/packages/ | grep murrine-themes )" ]; then
    sbopkg -B -i murrine-themes
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

  wget -N \
  https://raw.githubusercontent.com/numixproject/numix-kde-theme/master/Numix.colors -P /usr/share/apps/color-schemes/
  mv /usr/share/apps/color-schemes/Numix.colors /usr/share/apps/color-schemes/Numix-KDE.colors
  wget -N \
  https://raw.githubusercontent.com/numixproject/numix-kde-theme/master/Numix.qtcurve -P /usr/share/apps/QtCurve/
  mv /usr/share/apps/QtCurve/Numix.qtcurve /usr/share/apps/QtCurve/Numix-KDE.qtcurve

  ## caledonia kde theme
  wget -N \
  http://sourceforge.net/projects/caledonia/files/Caledonia%20%28Plasma-KDE%20Theme%29/$CALPLAS -P ~/
  tar xf ~/$CALPLAS -C /usr/share/apps/desktoptheme/
  rm ~/$CALPLAS

  ## caledonia color scheme
  wget -N http://sourceforge.net/projects/caledonia/files/Caledonia%20Color%20Scheme/Caledonia.colors \
  -P /usr/share/apps/color-schemes/

  ## get caledonia wallpapers, who doesn't like nice wallpapers?
  wget -N \
  http://sourceforge.net/projects/caledonia/files/Caledonia%20Official%20Wallpapers/$CALWALL -P ~/
  tar xf ~/$CALWALL
  cp -r ~/Caledonia_Official_Wallpaper_Collection/* /usr/share/wallpapers/
  rm -rf ~/Caledonia_Official_Wallpaper_Collection/
  rm ~/$CALWALL

  ## a few numix wallpapers also
  wget -N \
  http://fc03.deviantart.net/fs71/f/2013/305/3/6/numix___halloween___wallpaper_by_satya164-d6skv0g.zip -P ~/
  wget -N \
  http://fc00.deviantart.net/fs70/f/2013/249/7/6/numix___fragmented_space_by_me4oslav-d6l8ihd.zip -P ~/
  wget -N \
  http://fc09.deviantart.net/fs70/f/2013/224/b/6/numix___name_of_the_doctor___wallpaper_by_satya164-d6hvzh7.zip -P ~/
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
else
  echo "You have gone VANILLA."
fi


if [ "$WICD" = true ]; then
  slackpkg update gpg && slackpkg update
  slackpkg install wicd
  chmod -x /etc/rc.d/rc.networkmanager
  sed -i 's/^\([^#]\)/#\1/g' /etc/rc.d/rc.inet1.conf
  sed -i 's/^\([^#]\)/#\1/g' /etc/rc.d/rc.wireless.conf
fi

if [ "$NEARFREE" != true ] && [ "$MULTILIB" != true ] && [ "$MATE" = true ]; then
  slackpkg update gpg && slackpkg update
  slackpkg install-new && slackpkg upgrade-all
  ## set slackpkg to non-interactive mode to run without prompting
  sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf
  slackpkg update gpg && slackpkg update
  slackpkg install msb
fi

if [ "$NEARFREE" != true ] && [ "$MATE" != true ] && [ "$MULTILIB" = true ] && [ "$( uname -m )" = "x86_64" ]; then
  slackpkg update gpg && slackpkg update
  slackpkg install-new && slackpkg upgrade-all
  ## set slackpkg to non-interactive mode to run without prompting
  sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf
  slackpkg update gpg && slackpkg update
  slackpkg install multilib
fi

if [ "$NEARFREE" != true ] && [ "$SCRIPTS" = true ]; then
  if [ "$CURRENT" = true ]; then
    wget -N $GETEXTRACUR -P ~/
  else
    wget -N $GETEXTRASTA -P ~/
  fi

  ## slackbuilds repo
  git clone git://slackbuilds.org/slackbuilds.git sbo
  cd ~/sbo/
  git remote add hub https://github.com/ryanpcmcquen/slackbuilds-dot-org.git
  cd

  ## bumblebee/nvidia scripts
  if [ "$NEARFREE" != true ] && [ "$MULTILIB" != true ]; then
    wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/bumblebeeSetup.sh -P ~/
  fi
  if [ "$NEARFREE" != true ] && [ "$MATE" != true ] && [ "$MULTILIB" = true ] && [ "$( uname -m )" = "x86_64" ]; then
    wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/bumblebeeMultilibSetup.sh -P ~/
  fi

  ## my slackbuilds
  git clone https://github.com/ryanpcmcquen/ryanpc-slackbuilds.git
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




