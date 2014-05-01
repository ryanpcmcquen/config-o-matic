##config-o-matic

Slackware is easy to configure with config-o-matic.
Configure Slackware installs in no time with config-o-matic! (patent pending)

(Now supports 32 and 64 bit!)

(Note that $ user configuration is the same regardless of using stable or current.)


14.1:

    # curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfig14.1ROOT.sh | bash

14.1 w/Mate:

    # MATE=y curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfig14.1ROOT.sh | bash

current:

    # curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfigROOT.sh | bash

current w/Mate:

    # MATE=y curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfigROOT.sh | bash

Normal user (14.1 or current):

    $ curl https://raw2.github.com/ryanpcmcquen/config-o-matic/master/slackFluxConfig$.sh | bash


config-o-matic takes a text-oriented approach to system provisioning, for this reason, fluxbox is our current DE of choice. You may remove the flubox config url if you do not wish to use fluxbox. ;-)
