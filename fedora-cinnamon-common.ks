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

# make sure we have a graphical installer
gnome-software              # for update-notification
dnfdragora                  # for graphical (GTK and ncurses) package-management
libyui-mga-gtk              # GTK3-frontend for dnfdragora (graphical use)
libyui-mga-ncurses          # Ncurses-frontend for dnfdragora (text-mode use)

# nifty for installing not-found cli-commands
PackageKit-command-not-found

# extra backgrounds
desktop-backgrounds-basic
f25-backgrounds-extras-gnome

%end
