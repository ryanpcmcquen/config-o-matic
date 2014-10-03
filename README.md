#config-o-matic

Configure Slackware installs in no time with config-o-matic! (patent pending)

- Now supports 32 and 64 bit!


8 options are presented when running the ROOT script:


1. CURRENT: Switches to slackware-current/slackware64-current mirrors instead of stable.
2. WICD: Installs Wicd, disables NetworkManager.
3. NEARFREE: Follows http://freeslack.net/, but does not remove the kernel. This is NOT compatible with MISCELLANY, MATE, MULTILIB, PULSEAUDIO and SCRIPTS. If you select NEARFREE, you will NOT be presented with incompatible options.
4. MISCELLANY: Installs a lot of additional packages, themes and miscellany.
5. PULSEAUDIO: Installs PULSEAUDIO, effectively breaking sound.
6. SCRIPTS: Clones some git repos and helpful scripts into /root/.


###STABLE


Root user:

    #
    cd; wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user:

    $
    cd; wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


###CRAZY


Root user:

    #
    cd; wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user:

    $
    cd; wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


config-o-matic takes a text-oriented approach to system provisioning, for this reason, Fluxbox, KDE, Mate and XFCE are our current DE's of choice. You may remove any of the DE config url's if you do not use those environments.  ;^)

#NOTES:
 - You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

 - $ user configuration is the same regardless of using stable or current.

