# fedora-cinnamon-common.ks
#
# Description:
# - Fedora package set for the Cinnamon Desktop Environment
#
# Maintainer(s):
# - Dan Book <grinnz@grinnz.com>

%packages

@networkmanager-submodules
@cinnamon-desktop
@libreoffice

# internet and multimedia
pidgin
hexchat
transmission
parole

# make sure we have a graphical installer
gnome-software              # for update-notification
dnfdragora                  # for graphical (GTK and ncurses) package-management
libyui-mga-gtk              # GTK3-frontend for dnfdragora

# extra backgrounds
desktop-backgrounds-basic
f25-backgrounds-extras-gnome

# save some space
-PackageKit*                # we switched to gnome-software, so we don't need this

%end
