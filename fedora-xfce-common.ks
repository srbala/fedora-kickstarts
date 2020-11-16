# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@fedoraproject.org>


%packages

fedora-release-xfce
# install env-group to resolve RhBug:1891500
@^xfce-desktop-environment

@xfce-apps
@xfce-extra-plugins
@xfce-media
@xfce-office

# Add some screensavers, people seem to like them
# Note that blank is still default.
xscreensaver-extras
wget
system-config-printer

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-aspell-*                   # dictionaries are big
-xfce4-sensors-plugin

%end
