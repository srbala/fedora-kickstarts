# Description: Common gnome based configuration for NeuroFedora spin images.
#
# Maintained by the NeuroFedora SIG:
# https://neuro.fedoraproject.org
# mailto:neuro-sig@lists.fedoraproject.org

# Please specify the individual package sets in their own ks files:
# - fedora-comp-neuro-common.ks

%packages
@firefox

# Editors
emacs
vim-X11

# This is no longer workstation
-@workstation-product

# No Workstation backgrounds
#-desktop-backgrounds-basic
#-*backgrounds-extras
%end

%post

#Override the favorite desktop application in Dash
sed -i "s/favorite-apps=."'*'"/favorite-apps=['firefox.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'anaconda.desktop']/" /etc/rc.d/init.d/livesys

%end
