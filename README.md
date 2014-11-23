#config-o-matic

Configure Slackware installs in no time with config-o-matic! (patent pending)

- Now supports 32 and 64 bit!

NEARFREE: This is a separate script that should be run *instead* of the ROOT script. It follows http://freeslack.net/, but does not remove the kernel.

Options presented when running the ROOT script:


1. CURRENT: Switches to slackware-current/slackware64-current mirrors instead of stable.
2. WICD: Installs Wicd, disables NetworkManager.
3. MISCELLANY: Installs a lot of additional packages, themes and miscellany.
4. MULTILIB: Adds Eric Hameleer's MULTILIB repo to slackpkg+ and installs/upgrades it (64 bit only).


###STABLE


(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh```


###CRAZY


(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh```


config-o-matic takes a text-oriented approach to system provisioning, for this reason, Fluxbox, KDE, Mate and XFCE are our current DE's of choice. You may remove any of the DE config url's if you do not use those environments (although config-o-matic will try to detect them).  ;^)

#NOTES:
 - You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

 - $ user configuration is the same regardless of using stable or current.


####Ryan:

(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/ryan -P ~/; sh ~/ryan; rm ~/ryan```
