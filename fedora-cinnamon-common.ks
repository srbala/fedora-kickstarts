# fedora-cinnamon-common.ks
#
# Description:
# - Fedora package set for the Cinnamon Desktop Environment
#
# Maintainer(s):
# - Dan Book <grinnz@grinnz.com>

%packages

fedora-release-cinnamon

# install env-group to resolve RhBug:1891500
@^cinnamon-desktop-environment

@libreoffice
parole
rhythmbox

# extra backgrounds
f33-backgrounds-extras-gnome

%end
