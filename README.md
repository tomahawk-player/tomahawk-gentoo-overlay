DEPRECATED AND UNSUPPORTED
Gentoo overlay for Tomahawk
===========================

Official overlay has working ebuild for master version of tomahawk, just use it.



This overlay contains all missing packages that are needed for the lastest Tomahawk release and the live versions from git that are not yet part of the main Gentoo tree.

Installation (as root)
----------------------

```
wget https://raw.githubusercontent.com/tomahawk-player/tomahawk-gentoo-overlay/master/tomahawk-repo.xml -P /etc/layman/overlays
layman -S
layman -a tomahawk
emerge tomahawk
```
