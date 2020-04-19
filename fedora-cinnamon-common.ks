# fedora-cinnamon-common.ks
#
# Description:
# - Fedora package set for the Cinnamon Desktop Environment
#
# Maintainer(s):
# - Dan Book <grinnz@grinnz.com>

%packages

fedora-release-cinnamon
@networkmanager-submodules
@cinnamon-desktop
@libreoffice
parole

# extra backgrounds
f32-backgrounds-extras-gnome

%end
