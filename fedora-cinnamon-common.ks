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

# mp3 support
gstreamer1-plugin-mpg123

# bluetooth
cinnamon-applet-blueberry

# make sure we have a graphical installer
gnome-software              # for update-notification
dnfdragora-gui              # for graphical (GTK and ncurses) package-management

# extra backgrounds
desktop-backgrounds-basic
f25-backgrounds-extras-gnome

%end
