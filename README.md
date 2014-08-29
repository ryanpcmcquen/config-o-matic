#config-o-matic

Configure Slackware installs in no time with config-o-matic! (patent pending)

- Now supports 32 and 64 bit!


8 options are presented when running the ROOT script:

1. ASOUNDRC: Installs a ~/.asoundrc file that will change the primary sound output. Usually comps with HDMI ports have the HDMI output as primary which means your speakers will be muted until you install this file. You can see the file here: https://raw.githubusercontent.com/ryanpcmcquen/linuxTweaks/master/slackware/.asoundrc

  - If everything breaks after downloading the file just remove it with:

    rm ~/.asoundrc

2. CURRENT: Switches to slackware-current/slackware64-current mirrors instead of stable.
3. WICD: Installs Wicd, disables NetworkManager.
4. NEARFREE: Follows http://freeslack.net/, but does not remove the kernel. This is NOT compatible with MISCELLANY, MATE, MULTILIB and SCRIPTS. If you select NEARFREE, you will NOT be presented with incompatible options.
5. MISCELLANY: Installs a lot of additional packages, themes and miscellany.
6. MATE: Installs the Mate desktop environment. NOT compatible with MULTILIB.
7. MULTILIB: Installs 32-bit compatibility files for a 64-bit system, a la Eric Hameleers. NOT compatible with MATE.
8. SCRIPTS: Installs /extra/, the SBo git repo, and my SlackBuild repo into /root/.


###STABLE


Root user:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user:

    $
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


###CRAZY


Root user:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user:

    $
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


config-o-matic takes a text-oriented approach to system provisioning, for this reason, Fluxbox, KDE, XFCE and Mate are our current DE's of choice. You may remove any of the DE config url's if you do not use those environments.  ;^)

#NOTES:
 - You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

 - $ user configuration is the same regardless of using stable or current.

