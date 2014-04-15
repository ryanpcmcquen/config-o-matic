#!/bin/sh

# curl https://raw.github.com/ryanpcmcquen/linuxTweaks/master/slackware/config-o-matic/slackFluxConfig14.1ROOT.sh | bash

## set global config files & variables here:
$BASHGITVIM="https://raw.github.com/ryanpcmcquen/linuxTweaks/master/bashGitVimROOT.sh"
$SBOPKGDL="http://sbopkg.googlecode.com/files/sbopkg-0.37.0-noarch-1_cng.tgz"
$SPPLUSDL="http://sourceforge.net/projects/slackpkgplus/files/slackpkg%2B-1.3.1-noarch-1mt.txz"

if [ ! $UID = 0 ]; then
  cat << EOF

This script must be run as root.

EOF
  exit 1
fi

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

curl $BASHGITVIM | bash

wget -N $SBOPKGDL -P ~/
wget -N $SPPLUSDL -P ~/

installpkg ~/*.t?z

rm ~/sbopkg-0.37.0-noarch-1_cng.tgz
rm ~/slackpkg+-1.3.1-noarch-1mt.txz
