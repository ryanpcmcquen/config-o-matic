#!/bin/sh

# curl https://raw.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfig14.1ROOT.sh | bash

#$BASHGITVIM="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimROOT.sh"

## set global config files & variables here:
$SBOPKGDL="http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz"
$SPPLUSDL="http://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.3.1-noarch-1mt.txz"

$BASHRC="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bashrc"
$BASHPR="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bash_profile"

$VIMRC="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/.vimrc"

$GITNAME="Ryan Q"
$GITEMAIL="ryan.q@linux.com"


if [ ! $UID = 0 ]; then
  cat << EOF

This script must be run as root.

EOF
  exit 1
fi


wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/
wget -N $VIMRC -P ~/

## configure lilo
sed -i 's/^#compact/lba32\
compact/g' /etc/lilo.conf

sed -i 's/^timeout = 50/timeout = 5/g' /etc/lilo.conf
sed -i 's/^timeout = 1200/timeout = 5/g' /etc/lilo.conf

lilo

## change to utf-8 encoding
sed -i 's/^export LANG=en_US/#export LANG=en_US/g' /etc/profile.d/lang.sh
sed -i 's/^#export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g' /etc/profile.d/lang.sh

sed -i 's/#\[0-9]+_SBo/\
\[0-9]+_SBo\
sbopkg/g' /etc/slackpkg/blacklist

## choose 64-14.1 or 32 mirrorbrain mirror
sed -i 's_^# http://mirrors.slackware.com/slackware/slackware64-14.1/_http://mirrors.slackware.com/slackware/slackware64-14.1/_g' /etc/slackpkg/mirrors
sed -i 's_^# http://mirrors.slackware.com/slackware/slackware-14.1/_http://mirrors.slackware.com/slackware/slackware-14.1/_g' /etc/slackpkg/mirrors

## git config
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple

wget -N $SBOPKGDL -P ~/
wget -N $SPPLUSDL -P ~/

installpkg ~/*.t?z

rm ~/sbopkg-0.37.0-noarch-1_cng.tgz
rm ~/slackpkg+-1.3.1-noarch-1mt.txz
