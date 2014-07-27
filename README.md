#config-o-matic

Configure Slackware installs in no time with config-o-matic! (patent pending)

- Now supports 32 and 64 bit!

- Note that $ user configuration is the same regardless of using stable or current.


3 options are presented when running the ROOT script:

1. NEARFREE: Follows freeslack.net, but does not remove the kernel.
2. VANILLA: Does not install any extra packages.
3. MATE: Installs the Mate desktop environment.

Choosing 'no' on all 3 is considered the 'normal' route.


###STABLE


14.1:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfig14.1ROOT.sh; sh slackConfig14.1ROOT.sh; rm slackConfig14.1ROOT.sh

current:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user (14.1 or current):

    $
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/stable/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


###CRAZY


14.1:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig14.1ROOT.sh; sh slackConfig14.1ROOT.sh; rm slackConfig14.1ROOT.sh

current:

    #
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh; sh slackConfigROOT.sh; rm slackConfigROOT.sh

Normal user (14.1 or current):

    $
    wget -N https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig$.sh; sh slackConfig$.sh; rm slackConfig$.sh


config-o-matic takes a text-oriented approach to system provisioning, for this reason, Fluxbox, KDE, XFCE and Mate are our current DE's of choice. You may remove any of the DE config url's if you do not use those environments.  ;^)

#NOTE:
You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

