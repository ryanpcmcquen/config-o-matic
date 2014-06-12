##config-o-matic

Slackware is easy to configure with config-o-matic.
Configure Slackware installs in no time with config-o-matic! (patent pending)

(Now supports 32 and 64 bit!)

(Note that $ user configuration is the same regardless of using stable or current.)

If you do not want any extra packages, choose vanilla on ROOT script.

14.1:

    #
    curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig14.1ROOT.sh | sh

current:

    #
    curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfigROOT.sh | sh

Normal user (14.1 or current):

    $
    curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackConfig$.sh | sh


config-o-matic takes a text-oriented approach to system provisioning, for this reason, Fluxbox, KDE, XFCE and Mate are our current DE's of choice. You may remove any of the DE config url's if you do not use those environments.  ;^)

#NOTE:
You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

