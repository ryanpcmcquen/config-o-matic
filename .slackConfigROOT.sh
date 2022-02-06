#!/bin/sh

# cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/.slackConfigROOT.sh -P ~/; sh ~/.slackConfigROOT.sh

## Added in 4.2.0.
## Note that some configuration options may not match
## depending on the system, as config-o-matic tries
## to avoid overwriting most files.
CONFIGOMATICVERSION=10.0.16


if [ ! $UID = 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.__KEY_REPEAT_SETTINGS__ -P ~/
. ~/.__KEY_REPEAT_SETTINGS__

## versions!
cd
## Get stable slackware version:
wget www.slackware.com -O ~/slackware-home-page.html
grep "is released\!" ~/slackware-home-page.html | head -1 | sed 's/Slackware//g' | \
    sed 's/is released\!//g' | sed 's/ //g' > ~/slackwareStableVersion
rm -v ~/slackware-home-page.html

export SLACKSTAVER=${SLACKSTAVER="$(tr -d '\n\r' < ~/slackwareStableVersion)"}
export DASHSLACKSTAVER=${DASHSLACKSTAVER=-"$(tr -d '\n\r' < ~/slackwareStableVersion)"}

## sbopkg:
wget www.sbopkg.org -O ~/sbopkg-home-page.html
grep sbopkg ~/sbopkg-home-page.html | grep -G tgz | cut -d= -f2 | \
    cut -d'"' -f2 > ~/sbopkgVersion
rm -v ~/sbopkg-home-page.html

export SBOPKGDL=${SBOPKGDL="$(tr -d '\n\r' < ~/sbopkgVersion)"}

## Slackpkg+:
wget sourceforge.net/projects/slackpkgplus/files/ -O ~/slackpkgplus-download-page.html
grep slackpkg%2B ~/slackpkgplus-download-page.html | head -1 | cut -d= -f4 | sed 's/\/download//' | \
    tr -d '"' > ~/slackpkgPlusVersion
rm -v ~/slackpkgplus-download-page.html

export SPPLUSDL=${SPPLUSDL="$(tr -d '\n\r' < ~/slackpkgPlusVersion)"}


## Set config files:

## Sets ulimit, umask and whatnot:
INSCRPT="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/initscript"

BASHRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bashrc"
BASHPR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/root/.bash_profile"

VIMRC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.vimrc"
##VIMCOLOR="https://raw.githubusercontent.com/ryanpcmcquen/true-monochrome_vim/master/colors/true-monochrome.vim"

TMUXCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/tmux.conf"

SCITECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/.SciTEUser.properties"

GITNAME="Ryan McQuen"
GITEMAIL="rpcm@linux.com"

## These make you feel like the flash in vim:
XSETKEYDELAY=${KEY_REPEAT_DELAY}
XSETKEYRATE=${KEY_REPEAT_RATE}

TOUCHPCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/51-synaptics.conf"

WINECONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/wine.conf"

GETEXTRASLACK="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.getExtraSlackBuilds.sh"

GETSOURCESTA="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.getSystemSlackBuildsSTABLE.sh"
GETSOURCECUR="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.getSystemSlackBuildsCURRENT.sh"

MULTILIBINSTALLS="https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/.multilibInstalls"

GETJAVA="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.getJavaSlackBuild.sh"

MINECRAFTDL="https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar"

GKRELLM2THEME="https://github.com/ryanpcmcquen/themes/raw/master/egan-gkrellm.tar.gz"
FLUXBOXTHEME="https://github.com/ryanpcmcquen/themes/raw/master/67966-Stealthy-1.1.tgz"

GEANYCONF="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/geany.conf"

MULTILIBDEV="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.multilib-dev.sh"
MASSCONVERTANDINSTALLCOMPAT32CURRENT="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.mass_compat32ConvertAndInstall_CURRENT.sh"

EFILILO="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/EFI/lilo"

MSBHELPERSCRIPT="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/checkmate.sh"

MIMEAPPSLIST="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/mimeapps.list"

## Update chmod also:
UNICODEMAGIC="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/rc.unicodeMagic"
MAGICALXSET="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/magicalXSET"
GENERICKERNELSWITCHER="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.switchToGenericKernel.sh"
XFCESCREENSHOTSAVER="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/xfceScreenshotSaver"
SLACKWARECRONJOBUPDATE="https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/daily-slackup"

## Change to --utc if that is your thing:
SYSTEMCLOCKSYNCHRONIZATION="--localtime"

## We need this to determine if the system can install wine:
if [ -z "$COMARCH" ]; then
    case "$(uname -m)" in
        arm*) COMARCH=arm ;;
        *) COMARCH=$(uname -m) ;;
    esac
fi

## Set github clone source to ssh,
## if ssh key is there, otherwise
## use https.
if [ -e ~/.ryan ] && [ -d ~/.ssh/ ]; then
    GITHUBCLONESOURCE="git@github.com:"
else
    GITHUBCLONESOURCE="https://github.com/"
fi

### My shell functions:
make_sbo_pkg_upgrade_list() {
    sbopkg -c > ~/sbopkg-upgrade-list.txt
}

## The 'echo p' keeps sbopkg from prompting you if something goes wrong:
no_prompt_sbo_pkg_install_or_upgrade() {
    for ITEM in "$@"; do
        SBO_PACKAGE=$ITEM
        if [ -z "`find /var/log/packages/ -name ${SBO_PACKAGE}-*`" ] || [ "$(grep ${SBO_PACKAGE} ~/sbopkg-upgrade-list.txt)" ]; then
            echo p | sbopkg -B -e continue -i ${SBO_PACKAGE}
        fi
    done
}

slackpkg_update_only() {
    slackpkg update gpg
    slackpkg update
}

## A function in a function!
slackpkg_full_upgrade() {
    slackpkg_update_only
    if [ "$HEADLESS" = "no" ]; then
        slackpkg install-new
    fi
    slackpkg upgrade-all
}

## Actually pretty simple:
set_slackpkg_to_auto() {
    sed -i.bak 's/^BATCH=off/BATCH=on/g' /etc/slackpkg/slackpkg.conf
    sed -i.bak 's/^DEFAULT_ANSWER=n/DEFAULT_ANSWER=y/g' /etc/slackpkg/slackpkg.conf
}

set_slackpkg_to_manual() {
    sed -i.bak 's/^BATCH=on/BATCH=off/g' /etc/slackpkg/slackpkg.conf
    sed -i.bak 's/^DEFAULT_ANSWER=y/DEFAULT_ANSWER=n/g' /etc/slackpkg/slackpkg.conf
}

## Install packages from my unofficial GitHub repo:
my_repo_install() {
    ## Set to wherever yours is:
    MY_REPO=~/ryanpc-slackbuilds/unofficial
    ## Just do one initial pull:
    cd ${MY_REPO}/
    git pull
    ## Begin the beguine:
    for ITEM in "$@"; do
        MY_REPO_PKG=$ITEM
        ## Check if it is already installed:
        if [ -z "`find /var/log/packages/ -name ${MY_REPO_PKG}-*`" ]; then
            cd ${MY_REPO}/${MY_REPO_PKG}/
            . ${MY_REPO}/${MY_REPO_PKG}/${MY_REPO_PKG}.info
            ## No use trying to download if these vars are empty:
            if [ "$DOWNLOAD" ] || [ "$DOWNLOAD_x86_64" ]; then
                if [ "$(uname -m)" = "x86_64" ] && [ "$DOWNLOAD_x86_64" ] && [ "$DOWNLOAD_x86_64" != "UNSUPPORTED" ] && [ "$DOWNLOAD_x86_64" != "UNTESTED" ]; then
                    wget -N $DOWNLOAD_x86_64 -P ${MY_REPO}/${MY_REPO_PKG}/
                else
                    wget -N $DOWNLOAD -P ${MY_REPO}/${MY_REPO_PKG}/
                fi
            fi
            ## Finally, run the build:
            sh ${MY_REPO}/${MY_REPO_PKG}/${MY_REPO_PKG}.SlackBuild
            ##ls -t --color=never /tmp/${MY_REPO_PKG}-*_SBo.tgz | head -1 | xargs -i upgradepkg --install-new {}
            ## Everyone hates ls, so we use this fancy find command:
            find /tmp/ -maxdepth 1 -printf "%T@ %Tc=%p\n" | sort -n | grep "${MY_REPO_PKG}-*" | tail -1 | cut -d'=' -f2 | xargs -i upgradepkg --install-new {}
            cd
        fi
    done
}

### End of shell functions.

## Make sure we are home.
cd


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

## Go!

## OGCONFIG introduced in 6.6.0
if [ `find -name ".config-o-matic*" | sort | tail -1` ] && [ -z `. $(find -name ".config-o-matic*" | sort | tail -1)` ]; then
    read -p "Would you like to use your last CONFIGURATION?  [y/N]: " response
    case $response in
    [yY][eE][sS]|[yY])
        . "$(find -name '.config-o-matic*' | sort | tail -1)";
        export OGCONFIG=true;
        echo You respect your original choices.;
        ;;
    *)
        echo You want to try something new.;
        ;;
    esac
fi
if [ ! "$OGCONFIG" = true ]; then
    read -p "Would you like to switch to -CURRENT? \
        (NO = STABLE) \
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
    if [ "$COMARCH" != "arm" ]; then
        read -p "Would you like to install a bunch of MISCELLANY?  [y/N]: " response
        case $response in
            [yY][eE][sS]|[yY])
                export MISCELLANY=true;
                echo You are installing MISCELLANY.;
                ;;
            *)
                echo "You're pretty VANILLA, read the source for more.";
            ;;
        esac
    fi
    if [ "$(uname -m)" = "x86_64" ]; then
        read -p "Would you like to go MULTILIB?  [y/N]: " response
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
    read -p "Would you like to install WIFIR (easy wifi script)?  [y/N]: " response
    case $response in
        [yY][eE][sS]|[yY])
            export WIFIR=true;
            echo You have chosen to install WIFIR.;
        ;;
        *)
            echo You are not installing WIFIR.;
        ;;
    esac
fi

## Fix for Steam & Lutris.
dbus-uuidgen --ensure

## Detect efi and replace lilo with a script that works:
if [ -d /boot/efi/EFI/boot/ ]; then
    cp -v /sbin/lilo /sbin/lilo.orig
    wget -N $EFILILO -P /sbin/
fi

## No need to run this on efi:
if [ -e /etc/lilo.conf ]; then
    ## Configure lilo:
    sed -i.bak 's/^#compact/lba32\
    compact/g' /etc/lilo.conf

    ## Set to utf8:
    sed -i.bak 's/vt.default_utf8=0/vt.default_utf8=1/g' /etc/lilo.conf
    sed -i.bak 's/^timeout =.*/timeout = 5/g' /etc/lilo.conf
    if [ "$(grep 'vga=771' /etc/lilo.conf)" ]; then
        ## Uncomment all vga settings
        ## so we don't end up
        ## with conflicts.
        sed -i.bak "s_^vga_#vga_g" /etc/lilo.conf
        ## 800x600x256 (so we can see the penguins!)
        sed -i.bak "s_^#vga=771_vga=771_g" /etc/lilo.conf
    fi
fi

## Only run lilo if it exists (arm doesn't have it).
if [ "$(which lilo)" ]; then
    lilo -v
fi

## Change to utf-8 encoding:
sed -i.bak 's/^export LANG=en_US/#export LANG=en_US/g' /etc/profile.d/lang.sh
sed -i.bak 's/^#export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g' /etc/profile.d/lang.sh
## Set a utf8 font and other unicode-y stuff.
wget -N $UNICODEMAGIC -P /etc/rc.d/
chmod 755 /etc/rc.d/rc.unicodeMagic
## Start it!
/etc/rc.d/rc.unicodeMagic
## Make it start on boot:
if [ -z "$(grep unicodeMagic /etc/rc.d/rc.local)" ]; then
echo "if [ -x /etc/rc.d/rc.unicodeMagic ]; then
    /etc/rc.d/rc.unicodeMagic
fi" >> /etc/rc.d/rc.local
fi

# U2F:
wget -N https://raw.githubusercontent.com/Yubico/libu2f-host/master/70-u2f.rules -P /etc/udev/rules.d/

## Set some sane defaults for apps:
wget -N $MIMEAPPSLIST -P /etc/xdg/

## Set maximum keyboard repeat rate and shortest delay:
if [ -z "$(grep kbdrate /etc/rc.d/rc.local)" ]; then
    echo >> /etc/rc.d/rc.local
    echo "kbdrate -r 30.0 -d 250" >> /etc/rc.d/rc.local
    echo >> /etc/rc.d/rc.local
fi

## Doesn't matter if this is upgraded on stable,
## because it never gets upgraded on stable:
sed -i.bak 's/^aaa_elflibs/#aaa_elflibs/g' /etc/slackpkg/blacklist

## Blacklist SBo stuff:
sed -i.bak 's/#\[0-9]+_SBo/\
\[0-9]+_SBo\
\[0-9]+_sbopkg\
sbopkg/g' /etc/slackpkg/blacklist

## I always install jdk with Pat's script:
if [ -z "$(grep jdk /etc/slackpkg/blacklist)" ]; then
    echo jdk >> /etc/slackpkg/blacklist
    echo >> /etc/slackpkg/blacklist
fi

## Now with arm support (since 6.7.0)!
if [ "$COMARCH" != "arm" ]; then
    if [ "$CURRENT" = true ]; then
        ### Undo stable mirrors, do current:
        if [ "$(uname -m)" = "x86_64" ]; then
            sed -i.bak \
                "s_^http://mirrors.us.kernel.org/slackware/slackware64${DASHSLACKSTAVER}/_# http://mirrors.us.kernel.org/slackware/slackware64${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
            sed -i.bak \
                "s_^# http://mirrors.us.kernel.org/slackware/slackware64-current/_http://mirrors.us.kernel.org/slackware/slackware64-current/_g" /etc/slackpkg/mirrors
        else
            sed -i.bak \
                "s_^http://mirrors.us.kernel.org/slackware/slackware${DASHSLACKSTAVER}/_# http://mirrors.us.kernel.org/slackware/slackware${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
            sed -i.bak \
                "s_^# http://mirrors.us.kernel.org/slackware/slackware-current/_http://mirrors.us.kernel.org/slackware/slackware-current/_g" /etc/slackpkg/mirrors
        fi
    else
        ### Undo current, go stable:
        if [ "$(uname -m)" = "x86_64" ]; then
            sed -i.bak \
                "s_^http://mirrors.us.kernel.org/slackware/slackware64-current/_# http://mirrors.us.kernel.org/slackware/slackware64-current/_g" /etc/slackpkg/mirrors
            sed -i.bak \
                "s_^# http://mirrors.us.kernel.org/slackware/slackware64${DASHSLACKSTAVER}/_http://mirrors.us.kernel.org/slackware/slackware64${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
        else
            sed -i.bak \
                "s_^http://mirrors.us.kernel.org/slackware/slackware-current/_# http://mirrors.us.kernel.org/slackware/slackware-current/_g" /etc/slackpkg/mirrors
            sed -i.bak \
                "s_^# http://mirrors.us.kernel.org/slackware/slackware${DASHSLACKSTAVER}/_http://mirrors.us.kernel.org/slackware/slackware${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
        fi
    fi
else
    if [ "$CURRENT" = true ]; then
        ### Undo stable mirrors:
        sed -i.bak \
            "s_^http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm${DASHSLACKSTAVER}/_# http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
        ### Do the current:
        sed -i.bak \
            "s_^# http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm-current/_http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm-current/_g" /etc/slackpkg/mirrors
    else
        ### Undo current:
        sed -i.bak \
            "s_^http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm-current/_# http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm-current/_g" /etc/slackpkg/mirrors
        sed -i.bak \
            "s_^# http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm${DASHSLACKSTAVER}/_http://mirrors.vbi.vt.edu/mirrors/linux/slackwarearm/slackwarearm${DASHSLACKSTAVER}/_g" /etc/slackpkg/mirrors
    fi
fi


## Set vim as the default editor:
if [ -z "$(grep 'export EDITOR' /etc/profile && grep 'export VISUAL' /etc/profile)" ]; then
    echo >> /etc/profile
    echo "export EDITOR=vim" >> /etc/profile
    echo "export VISUAL=vim" >> /etc/profile
    echo >> /etc/profile
fi

## Make ls colorful by default, when
## parsing ls output, always use:
## ls --color=never
if [ -z "$(grep 'alias ls=' /etc/profile)" ]; then
    echo >> /etc/profile
    echo "alias ls='ls --color=auto'" >> /etc/profile
    echo >> /etc/profile
fi

## Make compiling faster:
if [ -z "$(grep 'MAKEFLAGS' /etc/profile)" ]; then
    echo >> /etc/profile
    echo 'if [ "$(nproc)" -gt 2 ]; then' >> /etc/profile
    ## Cores--:
    echo '  export MAKEFLAGS=" -j$(expr $(nproc) - 1) "' >> /etc/profile
    ## Half the cores:
    #echo '  export MAKEFLAGS=" -j$(expr $(nproc) / 2) "' >> /etc/profile
    echo 'else' >> /etc/profile
    echo '  export MAKEFLAGS=" -j1 "' >> /etc/profile
    echo 'fi' >> /etc/profile
    echo >> /etc/profile
fi

## Otherwise all our new stuff won't load until we log in again:
. /etc/profile


wget -N $BASHRC -P ~/
wget -N $BASHPR -P ~/
wget -N $VIMRC -P ~/
## I just include my theme in my .vimrc:
##mkdir -p ~/.vim/colors/
##wget -N $VIMCOLOR -P ~/.vim/colors/

## Touchpad configuration:
wget -N $TOUCHPCONF -P /etc/X11/xorg.conf.d/

## Init script:
wget -N $INSCRPT -P /etc/

## Gotta have some tmux:
wget -N $TMUXCONF -P /etc/

## Wine configuration, fixes preloader issues:
wget -N $WINECONF -P /etc/sysctl.d/

## Git config:
git config --global user.name "$GITNAME"
git config --global user.email "$GITEMAIL"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.pager "less -r"

## Give config-o-matic a directory to store
## all the crazy stuff we download.
mkdir -pv /var/cache/config-o-matic/{configs,images,pkgs,themes}/

## Install sbopkg & Slackpkg+:
wget -N $SBOPKGDL -P /var/cache/config-o-matic/pkgs/
if [ "$COMARCH" != "arm" ]; then
    wget -N $SPPLUSDL -P /var/cache/config-o-matic/pkgs/
fi
## Install the latest versions:
find /var/cache/config-o-matic/pkgs/ -name "sbopkg-*.t?z" | sort | tail -1 | xargs -i upgradepkg --install-new {}
find /var/cache/config-o-matic/pkgs/ -name "slackpkg+-*.t?z" | sort | tail -1 | xargs -i upgradepkg --install-new {}

## A few more vars:
if [ "`find /var/log/packages/ -name xorg-*`" ]; then
    export HEADLESS=no;
fi

## If we don't check for these, and the install fails,
## things get wonky.
if [ "`find /var/log/packages/ -name slackpkg+*`" ]; then
    export SPPLUSISINSTALLED=true;
fi
if [ "`which sbopkg`" ]; then
    export SBOPKGISINSTALLED=true;
fi

if [ "$SBOPKGISINSTALLED" = true ]; then
    ## Use SBo master as default ...
    ## but only comment out the old
    ## lines for an easy swap.
    if [ -z "$(egrep 'SBo master|REPO_BRANCH:-master' /etc/sbopkg/sbopkg.conf)" ]; then
        sed -i.bak "s@REPO_BRANCH=@#REPO_BRANCH=@g" /etc/sbopkg/sbopkg.conf
        sed -i.bak "s@REPO_NAME=@#REPO_NAME=@g" /etc/sbopkg/sbopkg.conf
        echo >> /etc/sbopkg/sbopkg.conf
        echo "## use the SBo master branch as the default" >> /etc/sbopkg/sbopkg.conf
        echo "REPO_BRANCH=\${REPO_BRANCH:-master}" >> /etc/sbopkg/sbopkg.conf
        echo "REPO_NAME=\${REPO_NAME:-SBo}" >> /etc/sbopkg/sbopkg.conf
        echo >> /etc/sbopkg/sbopkg.conf
    fi

    ## Applies to qemu:
    if [ -z "$(grep TARGETS /etc/sbopkg/sbopkg.conf)" ]; then
        echo "export TARGETS=\${TARGETS:-all}" >> /etc/sbopkg/sbopkg.conf
        echo >> /etc/sbopkg/sbopkg.conf
    fi
    ## Applies to a few packages:
    if [ "$MULTILIB" = true ]; then
        if [ -z "$(grep COMPAT32 /etc/sbopkg/sbopkg.conf)" ]; then
            echo "export COMPAT32=\${COMPAT32:-yes}" >> /etc/sbopkg/sbopkg.conf
            echo >> /etc/sbopkg/sbopkg.conf
        fi
    fi

    ## Create sbopkg directories:
    mkdir -pv /var/lib/sbopkg/{SBo,queues}/
    mkdir -pv /var/log/sbopkg/
    mkdir -pv /var/cache/sbopkg/
    mkdir -pv /tmp/SBo/
    ## reverse
    #rm -rfv /var/lib/sbopkg/
    #rm -rfv /var/log/sbopkg/
    #rm -rfv /var/cache/sbopkg/
    #rm -rfv /tmp/SBo/
fi

## GKrellM theme:
mkdir -pv /usr/share/gkrellm2/themes/
wget -N $GKRELLM2THEME -P /var/cache/config-o-matic/themes/
tar xvf /var/cache/config-o-matic/themes/egan-gkrellm.tar.gz -C /usr/share/gkrellm2/themes/

## Amazing stealthy Fluxbox:
wget -N $FLUXBOXTHEME -P /var/cache/config-o-matic/themes/
tar xvf /var/cache/config-o-matic/themes/67966-Stealthy-1.1.tgz -C /usr/share/fluxbox/styles/

## Set slackpkg to non-interactive mode to run without prompting:
set_slackpkg_to_auto

## To reset run with RESETSPPLUSCONF=y prepended, adds a
## bunch of mirrors for slackpkg+, as well as other
## settings, to the existing config, so updates
## are clean.
##
## Note that repo names must NOT contain a hyphen (-),
## use underscores instead (_), fixed in 7.3.15.
if [ "$SPPLUSISINSTALLED" = true ]; then
    if [ "$COMARCH" != "arm" ]; then
        if [ ! -e /etc/slackpkg/BACKUP-slackpkgplus.conf.old-BACKUP ] || [ "$RESETSPPLUSCONF" = y ]; then
            if [ "$RESETSPPLUSCONF" = y ]; then
                cp -v /etc/slackpkg/BACKUP-slackpkgplus.conf.old-BACKUP /etc/slackpkg/BACKUP0-slackpkgplus.conf.old-BACKUP0
                cp -v /etc/slackpkg/BACKUP-slackpkgplus.conf.old-BACKUP /etc/slackpkg/slackpkgplus.conf
            fi
            cp -v /etc/slackpkg/slackpkgplus.conf.new /etc/slackpkg/slackpkgplus.conf
            cp -v /etc/slackpkg/slackpkgplus.conf /etc/slackpkg/BACKUP-slackpkgplus.conf.old-BACKUP
            sed -i.bak 's@^REPOPLUS=( slackpkgplus restricted alienbob slacky )@#REPOPLUS=( slackpkgplus restricted alienbob slacky )@g' /etc/slackpkg/slackpkgplus.conf
            sed -i.bak 's@^REPOPLUS=( slackpkgplus )@#REPOPLUS=( slackpkgplus )@g' /etc/slackpkg/slackpkgplus.conf
            sed -i.bak "s@^MIRRORPLUS\['slacky'\]@#MIRRORPLUS['slacky']@g" /etc/slackpkg/slackpkgplus.conf

            echo >> /etc/slackpkg/slackpkgplus.conf
            echo >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( multilib:.* ktown:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( ktown:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( multilib:.* ktown_testing:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( ktown_testing:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            if [ "$MULTILIB" != true ]; then
                if [ "$CURRENT" = true ]; then
                    echo >> /etc/slackpkg/slackpkgplus.conf
                    echo "PKGS_PRIORITY=( restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
                else
                    echo "#PKGS_PRIORITY=( restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
                fi
                echo "#PKGS_PRIORITY=( multilib:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            fi

            if [ "$MULTILIB" = true ] && [ "$(uname -m)" = "x86_64" ]; then
                if [ "$CURRENT" = true ]; then
                    echo "MIRRORPLUS['multilib']=http://slackware.uk/people/alien/multilib/current/" \
                        >> /etc/slackpkg/slackpkgplus.conf
                    echo >> /etc/slackpkg/slackpkgplus.conf
                    echo "PKGS_PRIORITY=( multilib:.* restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
                else
                    echo "MIRRORPLUS['multilib']=http://slackware.uk/people/alien/multilib/${SLACKSTAVER}/" \
                        >> /etc/slackpkg/slackpkgplus.conf
                    echo >> /etc/slackpkg/slackpkgplus.conf
                    echo "PKGS_PRIORITY=( multilib:.* )" >> /etc/slackpkg/slackpkgplus.conf
                fi
                echo >> /etc/slackpkg/slackpkgplus.conf
                echo "#PKGS_PRIORITY=( restricted_current:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            fi

            echo >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( multilib:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( multilib:.* ktown:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( ktown:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( multilib:.* ktown_testing:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo "#PKGS_PRIORITY=( ktown_testing:.* alienbob_current:.* )" >> /etc/slackpkg/slackpkgplus.conf
            echo >> /etc/slackpkg/slackpkgplus.conf
            echo "#REPOPLUS=( slackpkgplus restricted alienbob slacky )" >> /etc/slackpkg/slackpkgplus.conf
            echo >> /etc/slackpkg/slackpkgplus.conf
            echo "REPOPLUS=( slackpkgplus restricted alienbob )" >> /etc/slackpkg/slackpkgplus.conf
            echo >> /etc/slackpkg/slackpkgplus.conf
            echo "#REPOPLUS=( slackpkgplus alienbob )" >> /etc/slackpkg/slackpkgplus.conf
            echo >> /etc/slackpkg/slackpkgplus.conf

            if [ "$(uname -m)" = "x86_64" ]; then
                echo >> /etc/slackpkg/slackpkgplus.conf
                echo "#MIRRORPLUS['ktown']=http://slackware.uk/people/alien-kde/current/latest/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                echo "#MIRRORPLUS['ktown_testing']=http://slackware.uk/people/alien-kde/current/testing/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                echo "MIRRORPLUS['alienbob']=http://bear.alienbase.nl/mirrors/people/alien/sbrepos/14.2/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                echo "MIRRORPLUS['restricted']=http://bear.alienbase.nl/mirrors/people/alien/restricted_sbrepos/14.2/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                if [ "$CURRENT" = true ]; then
                    echo "MIRRORPLUS['alienbob_current']=http://slackware.uk/people/alien/sbrepos/current/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                    echo "MIRRORPLUS['restricted_current']=http://slackware.uk/people/alien/restricted_sbrepos/current/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                else
                    echo "#MIRRORPLUS['alienbob_current']=http://slackware.uk/people/alien/sbrepos/current/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                    echo "#MIRRORPLUS['restricted_current']=http://slackware.uk/people/alien/restricted_sbrepos/current/x86_64/" >> /etc/slackpkg/slackpkgplus.conf
                fi
                echo >> /etc/slackpkg/slackpkgplus.conf
            else
                echo >> /etc/slackpkg/slackpkgplus.conf
                echo "#MIRRORPLUS['ktown']=http://slackware.uk/people/alien-kde/current/latest/x86/" >> /etc/slackpkg/slackpkgplus.conf
                echo "#MIRRORPLUS['ktown_testing']=http://slackware.uk/people/alien-kde/current/testing/x86/" >> /etc/slackpkg/slackpkgplus.conf
                echo "MIRRORPLUS['alienbob']=http://bear.alienbase.nl/mirrors/people/alien/sbrepos/14.2/x86/" >> /etc/slackpkg/slackpkgplus.conf
                echo "MIRRORPLUS['restricted']=http://bear.alienbase.nl/mirrors/people/alien/restricted_sbrepos/14.2/x86/" >> /etc/slackpkg/slackpkgplus.conf
                if [ "$CURRENT" = true ]; then
                    echo "MIRRORPLUS['alienbob_current']=http://slackware.uk/people/alien/sbrepos/current/x86/" >> /etc/slackpkg/slackpkgplus.conf
                    echo "MIRRORPLUS['restricted_current']=http://slackware.uk/people/alien/restricted_sbrepos/current/x86/" >> /etc/slackpkg/slackpkgplus.conf
                else
                    echo "#MIRRORPLUS['alienbob_current']=http://slackware.uk/people/alien/sbrepos/current/x86/" >> /etc/slackpkg/slackpkgplus.conf
                    echo "#MIRRORPLUS['restricted_current']=http://slackware.uk/people/alien/restricted_sbrepos/current/x86/" >> /etc/slackpkg/slackpkgplus.conf
                fi
                echo >> /etc/slackpkg/slackpkgplus.conf
            fi
        fi
    fi
fi

## This installs all the multilib/compat32 goodies,
## thanks to Eric Hameleers.
if [ "$SPPLUSISINSTALLED" = true ]; then
    if [ "$MULTILIB" = true ] && [ "$(uname -m)" = "x86_64" ]; then
        slackpkg_full_upgrade
        slackpkg_update_only
        slackpkg upgrade multilib
        slackpkg_update_only
        slackpkg install multilib
        set_slackpkg_to_auto

        ## Script to set up the environment for compat32 building:
        wget -N $MULTILIBDEV \
            -P ~/
        ## Script to build all compat32 packages:
        mkdir -pv ~/compat32/
        wget -N $MASSCONVERTANDINSTALLCOMPAT32CURRENT \
            -P ~/compat32/
    fi
fi

## This prevents breakage if slackpkg gets updated:
slackpkg_full_upgrade

## Mate:
git clone ${GITHUBCLONESOURCE}mateslackbuilds/msb.git

## Add a script to build & blacklist everything for msb:
wget -N $MSBHELPERSCRIPT -P ~/msb/

## Slackbook.org:
git clone git://slackbook.org/slackbook

## Enlightenment!
git clone ${GITHUBCLONESOURCE}ryanpcmcquen/slackENLIGHTENMENT.git

## My SlackBuilds:
git clone ${GITHUBCLONESOURCE}ryanpcmcquen/ryanpc-slackbuilds.git

if [ "${WIFIR}" = true ]; then
    ## A way to connect to WPA wifi without networkmanager:
    wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/wifir \
        -P /sbin/
    chmod 755 /sbin/wifir
    if [ -z "$(grep wifir /etc/rc.d/rc.local)" ]; then
        echo >> /etc/rc.d/rc.local
        echo "if [ -x /sbin/wifir ]; then" >> /etc/rc.d/rc.local
        echo "    /sbin/wifir" >> /etc/rc.d/rc.local
        echo "fi" >> /etc/rc.d/rc.local
        echo >> /etc/rc.d/rc.local
    fi
fi

## A script to allow promptless saving of xfce
## screenshots, with a nice timestamp:
wget -N $XFCESCREENSHOTSAVER \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/xfceScreenshotSaver

## Copy email addresses to the clipboard (and remove spaces):
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/clip-handler -P /usr/local/bin/
chmod 755 /usr/local/bin/clip-handler
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/clip-handler.desktop -P /usr/share/applications/

## Script to download tarballs from SlackBuild .info files:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sboGizmos/sbdl \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/sbdl

## Simpler version of download script
## only downloads for your ARCH:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sboGizmos/sbdl0 \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/sbdl0

## Update version vars for SBo builds:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sboGizmos/sbup \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/sbup

## Put md5sums in info file for easier updates:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/sboGizmos/sbmd \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/sbmd

if [ "$SPPLUSISINSTALLED" = true ]; then
    if [ "$MISCELLANY" = true ]; then
        ## Set slackpkg to non-interactive mode to run without prompting,
        ## we set again just in case someone overwrites configs.
        set_slackpkg_to_auto
        slackpkg_update_only

        ## Auto-update once a day to keep the doctor away:
        wget -N \
            $SLACKWARECRONJOBUPDATE \
            -P /etc/cron.daily/
        chmod -v 755 /etc/cron.daily/daily-slackup

        ## Set up ntp daemon (the good way):
        if [ -x /etc/rc.d/rc.ntpd ]; then
            /etc/rc.d/rc.ntpd stop
        fi
        ntpdate 0.pool.ntp.org
        ntpdate 1.pool.ntp.org
        hwclock --systohc ${SYSTEMCLOCKSYNCHRONIZATION}
        sed -i.bak 's/#server pool.ntp.org iburst / \
            server 0.pool.ntp.org iburst \
            server 1.pool.ntp.org iburst \
            server 2.pool.ntp.org iburst \
            server 3.pool.ntp.org iburst \
            /g' /etc/ntp.conf
        chmod -v +x /etc/rc.d/rc.ntpd
        /etc/rc.d/rc.ntpd start
    fi
fi

if [ "$SBOPKGISINSTALLED" = true ]; then
    ## Check for sbopkg update, then sync
    ## the slackbuilds.org repo:
    sbopkg -B -u
    sbopkg -B -r
    ## Generate a readable list:
    make_sbo_pkg_upgrade_list
fi

if [ "$VANILLA" = "yes" ] || [ "$HEADLESS" != "no" ] || [ "$SPPLUSISINSTALLED" != true ]; then
    echo "Headless, source reader or server errors?"
elif [ "$SBOPKGISINSTALLED" = true ]; then
    ###########
    ### dwm ###
    ###########

    ## Sweet, sweet dwm.
    no_prompt_sbo_pkg_install_or_upgrade dwm
    no_prompt_sbo_pkg_install_or_upgrade dmenu
    no_prompt_sbo_pkg_install_or_upgrade st
    no_prompt_sbo_pkg_install_or_upgrade trayer-srg
    #no_prompt_sbo_pkg_install_or_upgrade tinyterm
    no_prompt_sbo_pkg_install_or_upgrade xbindkeys

    ## Hard to live without these:
    set_slackpkg_to_auto
    slackpkg_update_only
    slackpkg install bash-completion vlc

    ## These are essential also, install any true multilib
    ## packages with a separate script:
    if [ "$MULTILIB" = true ]; then
        curl $MULTILIBINSTALLS | sh
    else
        no_prompt_sbo_pkg_install_or_upgrade libtxc_dxtn
        no_prompt_sbo_pkg_install_or_upgrade OpenAL
    fi

    ## Allow wine/crossover to use osmesa libs:
    if [ ! -e /usr/lib/libOSMesa.so.6 ]; then
        ln -sfv /usr/lib/libOSMesa.so /usr/lib/libOSMesa.so.6
    fi

    ## Love this editor!
    no_prompt_sbo_pkg_install_or_upgrade scite
    wget -N $SCITECONF \
        -P ~/
    ## Clean, simple text editor.
    no_prompt_sbo_pkg_install_or_upgrade textadept

    ## Everyone needs patchutils!
    no_prompt_sbo_pkg_install_or_upgrade patchutils

    no_prompt_sbo_pkg_install_or_upgrade imlib2
    no_prompt_sbo_pkg_install_or_upgrade giblib
    ## Screenfetch is a great utility, and
    ## Scrot makes it easy to take
    ## screenshots with it.
    no_prompt_sbo_pkg_install_or_upgrade scrot
    no_prompt_sbo_pkg_install_or_upgrade screenfetch

    ## Great image viewer/editor, simple and fast:
    no_prompt_sbo_pkg_install_or_upgrade mirage

    ## My dwm tweaks:
    wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/dwm-autostart \
        -P /usr/local/etc/

    ## Make tinyterm the default:
    #ln -sfv /usr/bin/tinyterm /usr/local/bin/uxterm
    #ln -sfv /usr/bin/tinyterm /usr/local/bin/xterm
    #ln -sfv /usr/bin/tinyterm /usr/local/bin/Eterm
    #ln -sfv /usr/bin/tinyterm /usr/local/bin/st

    ###########
    ### end ###
    ### dwm ###
    ###########

    ## These are for the image ultimator
    no_prompt_sbo_pkg_install_or_upgrade nodejs
    no_prompt_sbo_pkg_install_or_upgrade jpegoptim
    no_prompt_sbo_pkg_install_or_upgrade mozjpeg
    no_prompt_sbo_pkg_install_or_upgrade optipng
    no_prompt_sbo_pkg_install_or_upgrade pngquant
    no_prompt_sbo_pkg_install_or_upgrade gifsicle
    npm install -g svgo
    ## Install the image ultimator now that we have the dependencies:
    wget -N \
        https://raw.githubusercontent.com/ryanpcmcquen/image-ultimator/master/imgult -P /var/cache/config-o-matic/
    install -v -m755 /var/cache/config-o-matic/imgult /usr/local/bin/
    ## End of imgult stuff.

    ## Mozilla's html linter:
    wget -N https://raw.githubusercontent.com/mozilla/html5-lint/master/html5check.py -P /usr/local/bin/
    chmod 755 /usr/local/bin/html5check.py

    ## Needed for the clip handler:
    no_prompt_sbo_pkg_install_or_upgrade xclip

    ## webDev stuff:
    no_prompt_sbo_pkg_install_or_upgrade jsmin
    npm install -g prettier
    ## These are my jam:
    no_prompt_sbo_pkg_install_or_upgrade sublime_text
    no_prompt_sbo_pkg_install_or_upgrade sublime_merge

    ## Encrypt all the things!
    no_prompt_sbo_pkg_install_or_upgrade google-go-lang
    no_prompt_sbo_pkg_install_or_upgrade keybase

    ## If using an intel processor, grab the microcode,
    ## seems to help battery life significantly.
    [ "lspci | grep -i intel | grep -i processor" ] \
        && no_prompt_sbo_pkg_install_or_upgrade intel-microcode

    ## Always improve battery life!
    no_prompt_sbo_pkg_install_or_upgrade TLP
    chmod 755 /etc/rc.d/rc.tlp
    if [ -z "$(grep 'rc.tlp' /etc/rc.d/rc.local)" ]; then
        echo >> /etc/rc.d/rc.local
        echo "if [ -x /etc/rc.d/rc.tlp ]; then" >> /etc/rc.d/rc.local
        echo "    /etc/rc.d/rc.tlp start" >> /etc/rc.d/rc.local
        echo "fi" >> /etc/rc.d/rc.local
        echo >> /etc/rc.d/rc.local
    fi

fi

if [ "$SPPLUSISINSTALLED" = true ] && [ "$SBOPKGISINSTALLED" = true ]; then
    if [ "$MISCELLANY" = true ]; then
        pip install --upgrade pip || no_prompt_sbo_pkg_install_or_upgrade pip

        no_prompt_sbo_pkg_install_or_upgrade asciinema

        ## More compilers, more fun!
        no_prompt_sbo_pkg_install_or_upgrade pcc
        no_prompt_sbo_pkg_install_or_upgrade tcc

        ## A lot of stuff depends on Lua:
        no_prompt_sbo_pkg_install_or_upgrade lua
        no_prompt_sbo_pkg_install_or_upgrade luajit

        ## I can't remember why this is here:
        no_prompt_sbo_pkg_install_or_upgrade bullet

        ## Helps with webkit and some other things:
        no_prompt_sbo_pkg_install_or_upgrade libwebp

        ## Need these for ffmpeg:
        no_prompt_sbo_pkg_install_or_upgrade x264

        no_prompt_sbo_pkg_install_or_upgrade ssr

        no_prompt_sbo_pkg_install_or_upgrade rar
        no_prompt_sbo_pkg_install_or_upgrade unrar

        ## A whole bunch of archive-y/file stuff:
        no_prompt_sbo_pkg_install_or_upgrade libisofs
        no_prompt_sbo_pkg_install_or_upgrade libburn
        no_prompt_sbo_pkg_install_or_upgrade libisoburn
        no_prompt_sbo_pkg_install_or_upgrade isomaster
        no_prompt_sbo_pkg_install_or_upgrade xarchiver
        no_prompt_sbo_pkg_install_or_upgrade dmg2img

        ## CodeBlocks & PlayOnLinux need this:
        no_prompt_sbo_pkg_install_or_upgrade wxPython
        ## Audacity needs this:
        no_prompt_sbo_pkg_install_or_upgrade wxGTK3

        ## If you want the gui here, pass: GUI=yes
        no_prompt_sbo_pkg_install_or_upgrade p7zip

        no_prompt_sbo_pkg_install_or_upgrade libmspack

        ## Nostalgic for me:
        no_prompt_sbo_pkg_install_or_upgrade codeblocks
        no_prompt_sbo_pkg_install_or_upgrade geany
        no_prompt_sbo_pkg_install_or_upgrade geany-plugins

        ## Add global Geany configuration:
        wget -N $GEANYCONF -P /usr/share/geany/

        ## Good ol' Audacity:
        no_prompt_sbo_pkg_install_or_upgrade soundtouch
        no_prompt_sbo_pkg_install_or_upgrade vamp-plugin-sdk
        no_prompt_sbo_pkg_install_or_upgrade audacity

        ## I may make stuff someday:
        no_prompt_sbo_pkg_install_or_upgrade blender

        ## Works great with drawing tablets.
        ## It also requires `numpy`.
        no_prompt_sbo_pkg_install_or_upgrade numpy
        no_prompt_sbo_pkg_install_or_upgrade mypaint

        ## Open non-1337 stuff:
        no_prompt_sbo_pkg_install_or_upgrade libreoffice

        ## Open dwg:
        no_prompt_sbo_pkg_install_or_upgrade qcad

        ## Great for making presentations:
        no_prompt_sbo_pkg_install_or_upgrade mdp

        ## Retro games!
        no_prompt_sbo_pkg_install_or_upgrade higan
        no_prompt_sbo_pkg_install_or_upgrade mednafen
        no_prompt_sbo_pkg_install_or_upgrade dosbox

        ## Steam!
        my_repo_install steam

        ## Desura is down.
        # if [ "$(uname -m)" = "x86_64" ]; then
        #     wget -N http://www.desura.com/desura-x86_64.tar.gz \
        #         -P /var/cache/config-o-matic/
        # else
        #     wget -N http://www.desura.com/desura-i686.tar.gz \
        #         -P /var/cache/config-o-matic/
        # fi
        # tar xvf /var/cache/config-o-matic/desura-*.tar.gz -C /opt/
        # ln -sfv /opt/desura/desura /usr/local/bin/

        ## Minecraft!!
        mkdir -pv /opt/minecraft/
        wget -N $MINECRAFTDL -P /opt/minecraft/
        wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/minecraft -P /usr/local/bin/
        chmod 755 /usr/local/bin/minecraft

        ## Grab Pat's java SlackBuild:
        curl $GETJAVA | sh

        ## Symlink all wallpapers so they show up in other DE's:
        mkdir -pv /usr/share/backgrounds/mate/custom/
        find /usr/share/wallpapers -type f -a \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.jpe' -o -iname '*.gif' -o -iname '*.png' \) \
            -exec ln -sf {} /usr/share/backgrounds/mate/custom/ \;
        find /usr/share/wallpapers -type f -a \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.jpe' -o -iname '*.gif' -o -iname '*.png' \) \
            -exec ln -sf {} /usr/share/backgrounds/xfce/ \;

        ## Icon caches are a bad idea (thanks to Pat):
        ## http://www.linuxquestions.org/questions/slackware-14/since-going-multilib-boot-time-really-slow-4175460903/page2.html#post4949839
        find /usr/share/icons -name icon-theme.cache -exec rm "{}" \;
    else
        echo "You have gone VANILLA."
    fi
fi

## Make yourself the flash:
if [ -z "$(grep 'xset r rate' /etc/X11/xinit/xinitrc.*)" ]; then
    sed -i.bak 's@if \[ -z "\$DESKTOP_SESSION"@\
        xset\ r\ rate\ '"$XSETKEYDELAY"'\ '"$XSETKEYRATE"'\
        \
        if \[ -z "\$DESKTOP_SESSION"@g' \
    /etc/X11/xinit/xinitrc.*
fi

## dwm is its own thing:
if [ -z "$(grep 'xset r rate' /etc/X11/xinit/xinitrc.dwm)" ]; then
    sed -i.bak 's@if \[ -z "\$DESKTOP_SESSION"@\
        xset\ r\ rate\ '"$XSETKEYDELAY"'\ '"$XSETKEYRATE"'\
        \
        if \[ -z "\$DESKTOP_SESSION"@g' \
    /etc/X11/xinit/xinitrc.dwm
fi
if [ -z "$(grep 'dwm-autostart' /etc/X11/xinit/xinitrc.dwm)" ]; then
    sed -i.bak 's@xset\ r\ rate.*@\
        \#\#\ my\ startup\ file\
        sh\ /usr/local/etc/dwm-autostart\
        \
        xset\ r\ rate\ '"$XSETKEYDELAY"'\ '"$XSETKEYRATE"'\
        @g' \
    /etc/X11/xinit/xinitrc.dwm
fi

## Move any backup files to a separate directory,
## so that `xwmconfig` doesn't become a mess.
mkdir -pv /etc/X11/xinit/BACKUPS/
mv /etc/X11/xinit/xinitrc.*.bak /etc/X11/xinit/BACKUPS/

## This file makes it easy to change the xset delay and rate:
wget -N $MAGICALXSET \
    -P /etc/X11/xinit/

## Used to be the beginning of SCRIPTS.

wget -N $GETEXTRASLACK -P ~/

if [ "$CURRENT" = true ]; then
    wget -N $GETSOURCECUR -P ~/
else
    wget -N $GETSOURCESTA -P ~/
fi

wget -N $GETJAVA -P ~/

## Bumblebee/nvidia scripts:
if [ "$(lspci | grep NVIDIA)" ]; then
    wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/crazybee.sh -P ~/
fi

## Auto generic-kernel script:
wget -N $GENERICKERNELSWITCHER -P ~/
chmod 755 ~/.switchToGenericKernel.sh

## Compile latest mainline/stable/longterm kernel:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/kernelMe.sh -P /usr/src/
chmod 755 /usr/src/kernelMe.sh

if [ "`find /var/log/packages/ -name raspi-*`" ]; then
    curl -L --output /usr/bin/rpi-update https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update \
        && chmod +x /usr/bin/rpi-update
fi

## Script to install latest Firefox developer edition:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/ryanpc-slackbuilds/master/unofficial/fde/.getFDE.sh -P ~/

## Run mednafen with sexyal-literal-default:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/medna \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/medna

## Make a shortcut to crossover:
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/cxo \
    -P /usr/local/bin/
chmod 755 /usr/local/bin/cxo

## Fast fox!
wget -N https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/ff \
    -P /usr/local/bin/
cp -v /usr/local/bin/ff /usr/local/bin/firefox
chmod 755 /usr/local/bin/ff /usr/local/bin/firefox

## Used to be the end of SCRIPTS.

if [ -d /etc/NetworkManager/system-connections ] && [ -x /etc/rc.d/rc.networkmanager ]; then
    ## Make all networkmanager connections available system-wide:
    for NET in `find /etc/NetworkManager/system-connections/ -name "*" | cut -d'/' -f5 | grep -v ^$`
        do nmcli con mod "$NET" connection.permissions ' '
    done
fi

## Set slackpkg back to normal:
set_slackpkg_to_manual


## Create an info file:
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "########################################" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "## CONFIG-O-MATIC $CONFIGOMATICVERSION ##" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "## BLANK=false ##" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION

echo "VANILLA=$VANILLA" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "HEADLESS=$HEADLESS" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "## SPPLUSISINSTALLED=$SPPLUSISINSTALLED" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "## SBOPKGISINSTALLED=$SBOPKGISINSTALLED" >> ~/.config-o-matic_$CONFIGOMATICVERSION

echo >> ~/.config-o-matic_$CONFIGOMATICVERSION

echo "CURRENT=$CURRENT" >> ~/.config-o-matic_$CONFIGOMATICVERSION
if [ "$COMARCH" != "arm" ]; then
    echo "MISCELLANY=$MISCELLANY" >> ~/.config-o-matic_$CONFIGOMATICVERSION
fi
if [ "$(uname -m)" = "x86_64" ]; then
    echo "MULTILIB=$MULTILIB" >> ~/.config-o-matic_$CONFIGOMATICVERSION
fi
echo "WIFIR=$WIFIR" >> ~/.config-o-matic_$CONFIGOMATICVERSION

echo >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo "########################################" >> ~/.config-o-matic_$CONFIGOMATICVERSION
echo >> ~/.config-o-matic_$CONFIGOMATICVERSION

rm -v ~/slackwareStableVersion
rm -v ~/sbopkgVersion
rm -v ~/sbopkg-upgrade-list.txt
rm -v ~/slackpkgPlusVersion

## Thanks!
echo
echo
echo "************************************"
echo "********** CONFIG-O-MATIC **********"
echo "************************************"
echo
echo "Your system is now set to UTF-8."
echo "(e.g. You should use uxterm, instead of xterm)."
echo "Thank you for using config-o-matic!"
echo
echo "You should now run the $ user script."
echo
