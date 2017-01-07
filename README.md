# config-o-matic

Configure FreeSlack installs in no time with config-o-matic!

Options presented when running the ROOT script:

1. MISCELLANY: Installs a lot of additional packages, themes and miscellany.
2. MULTILIB: Adds Eric Hameleer's MULTILIB repo to slackpkg+ and installs/upgrades it (64 bit only).
3. WIFIR: An easy wifi connection script. Reliable and simple. See it [here](https://github.com/ryanpcmcquen/linuxTweaks/blob/master/slackware/wifir).

##### config-o-matic does a lot! You should read through the script and remove any parts you don't want.  ;-)
---

(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/libre/.freeYourROOT.sh -P ~/; sh ~/.freeYourROOT.sh```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/libre/.freeYourself.sh -P ~/; sh ~/.freeYourself.sh```

---
To enable the wheel group, and add all non-root users to it (as well as the typical Slackware groups), run this:

```
## Enable the wheel group:
if [ ! -e /etc/sudoers.d/wheel-enable ]; then
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel-enable
fi

## Add all non-root users (except ftp) to wheel group:
getent passwd | grep "/home" | cut -d: -f1 | sed '/ftp/d' | xargs -i usermod -G wheel -a {}
## The standard groups in case you forget when you run adduser.  ;-)
getent passwd | grep "/home" | cut -d: -f1 | sed '/ftp/d' | \
  xargs -i usermod -G audio,cdrom,floppy,plugdev,video,power,netdev,lp,scanner -a {}
```
---

# NOTES:
 - You should either fork this project or download it and set it to YOUR config files, just running my scripts will set up my preferred configs.

 - $ user configuration is the same regardless of using stable or current.

---
#### Me:

(#):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/libre/.meROOT -P ~/; sh ~/.meROOT```

($):

```cd; wget -N https://raw.githubusercontent.com/ryanpcmcquen/config-o-matic/libre/.me -P ~/; sh ~/.me```

