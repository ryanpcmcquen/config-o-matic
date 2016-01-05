#config-o-matic

Configure Slackware installs in no time with config-o-matic! (patent pending)

NEARFREE: This is a separate script that should be run *instead* of the ROOT script. It follows http://freeslack.net/, but does not remove the kernel.

Options presented when running the ROOT script:

1. CURRENT: Switches to slackware-current/slackware64-current mirrors instead of stable.
2. MISCELLANY: Installs a lot of additional packages, themes and miscellany.
3. MULTILIB: Adds Eric Hameleer's MULTILIB repo to slackpkg+ and installs/upgrades it (64 bit only).

#####config-o-matic does a lot! You should read through the script and remove any parts you don't want.  ;-)
---

(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/.slackConfigROOT.sh -P ~/; sh ~/.slackConfigROOT.sh```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/stable/.slackConfig%24.sh -P ~/; sh ~/.slackConfig\$.sh```

---
To enable the wheel group, and add all non-root users to it (as well as the typical Slackware groups, run this:

```
## enable the wheel group
if [ ! -e /etc/sudoers.d/wheel-enable ]; then
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel-enable
fi

## add all non-root users (except ftp) to wheel group
getent passwd | grep "/home" | cut -d: -f1 | sed '/ftp/d' | xargs -i usermod -G wheel -a {}
## the standard groups in case you forget when you run adduser  ;-)
getent passwd | grep "/home" | cut -d: -f1 | sed '/ftp/d' | \
  xargs -i usermod -G audio,cdrom,floppy,plugdev,video,power,netdev,lp,scanner -a {}
```
---

#NOTES:
 - You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

 - $ user configuration is the same regardless of using stable or current.

---
####ryan:

(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/.ryan -P ~/; sh ~/.ryan```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/master/.ryan%24 -P ~/; sh ~/.ryan\$```

