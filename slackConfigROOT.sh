#!/bin/sh

# curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh | sh

## w/Mate
# export MATE=true; curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh | sh


#$BASHGITVIM="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimROOT.sh"

## set global config files & variables here:
SBOPKGDL="http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz"
SPPLUSDL="http://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.3.1-noarch-4mt.txz"
SPPLUSCONF64="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/64/slackpkgplus.conf"
SPPLUSCONF32="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/32/slackpkgplus.conf"

INSCRPT="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/initscript"

BASHRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bashrc"
BASHPR="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bash_profile"

VIMRC="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

GITNAME="Ryan Q"
GITEMAIL="ryan.q@linux.com"

TOUCHPCONF="https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/51-synaptics.conf"


if [ ! $UID = 0 ]; then
  cat << EOF
This script must be run as root.
EOF
  exit 1
fi


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


## adjust slackpkg blacklist
sed -i 's/^aaa_elflibs/#aaa_elflibs/g' /etc/slackpkg/blacklist

sed -i 's/#\[0-9]+_SBo/\
\[0-9]+_SBo\
sbopkg/g' /etc/slackpkg/blacklist

### choose 32 or 64-current mirrorbrain
##sed -i 's_^# http://mirrors.slackware.com/slackware/slackware64-current/_http://mirrors.slackware.com/slackware/slackware64-current/_g' /etc/slackpkg/mirrors
##sed -i 's_^# http://mirrors.slackware.com/slackware/slackware-current/_http://mirrors.slackware.com/slackware/slackware-current/_g' /etc/slackpkg/mirrors


### osuosl mirrors are stable and fast (they are used for the changelogs), choose mirrorbrain if you are far from oregon
sed -i 's_^# http://ftp.osuosl.org/.2/slackware/slackware-current/_http://ftp.osuosl.org/.2/slackware/slackware-current/_g' /etc/slackpkg/mirrors
sed -i 's_^# http://ftp.osuosl.org/.2/slackware/slackware64-current/_http://ftp.osuosl.org/.2/slackware/slackware64-current/_g' /etc/slackpkg/mirrors


wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/
wget -N $VIMRC -P ~/

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"


wget -N $TOUCHPCONF -P /etc/X11/xorg.conf.d/

wget -N $SBOPKGDL -P ~/
wget -N $SPPLUSDL -P ~/

installpkg ~/*.t?z

mv /etc/slackpkg/slackpkgplus.conf /etc/slackpkg/slackpkgplus.conf.old

if [ "$( uname -m )" = "x86_64" ]; then
  wget -N $SPPLUSCONF64 -P /etc/slackpkg/
else
  wget -N $SPPLUSCONF32 -P /etc/slackpkg/
fi

rm ~/*.t?z

wget -N $INSCRPT -P /etc/

## you should export VANILLA=true; if you don't want these ;-)
if [ "$VANILLA" = true ]; then
  echo "You have gone vanilla."
else
  ## set slackpkg to non-interactive mode so we can install packages without delay
  #sed -i 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
  #sed -i 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf
  BATCH=on DEFAULT_ANSWER=y slackpkg update gpg && slackpkg update && slackpkg install-new && slackpkg upgrade-all
  
  #BATCH=on DEFAULT_ANSWER=y slackpkg update gpg && BATCH=on DEFAULT_ANSWER=y slackpkg update && \
  #BATCH=on DEFAULT_ANSWER=y slackpkg install-new && BATCH=on DEFAULT_ANSWER=y slackpkg upgrade-all
  BATCH=on DEFAULT_ANSWER=y slackpkg install wicd ffmpeg vlc chromium copy-client
  
  chmod -x /etc/rc.d/rc.networkmanager
  chmod -x /etc/rc.d/rc.wireless
  chmod -x /etc/rc.d/rc.inet*
  
  ## ntp cron job (the bad way)
  #wget -N https://raw2.github.com/ryanpcmcquen/linuxTweaks/master/slackware/clocksync -P /etc/cron.daily/
  
  ## set up ntp daemon (the good way)
  sed -i 's/#server pool.ntp.org iburst \
  server 0.pool.ntp.org iburst \
  server 1.pool.ntp.org iburst \
  server 2.pool.ntp.org iburst \
  server 3.pool.ntp.org iburst \
  /g' /etc/ntp.conf
  chmod +x /etc/rc.d/rc.ntpd
  
  sbopkg -B -r; sbopkg -B -i superkey-launch -i lxterminal
fi


if [ "$MATE" = true ]; then
  slackpkg install msb
fi


echo "Thank you for using config-o-matic!"
echo "You should now run 'adduser', if you have not."
