##config-o-matic

Slackware is easy to configure with config-o-matic.
Configure Slackware installs in no time with config-o-matic! (patent pending)

(Now supports 32 and 64 bit!)

(Note that $ user configuration is the same regardless of using stable or current.)

If you do not want any extra packages, choose VANILLA on ROOT script.

NEARFREE option now to remove all non-free packages except the kernel. At this time,
NEARFREE is not valid with any other options.


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

