# fedora-livecd-cinnamon-de_DE.ks
#
# Description:
# - German Fedora Live Spin with the Cinnamon Desktop Environment
#
# Maintainer(s):
# - Björn Esser <besser82@fedoraproject.org>

%include ../fedora-live-cinnamon.ks

lang de_DE.UTF-8
keyboard de-latin1-nodeadkeys
timezone Europe/Berlin

%packages
langpacks-de
# exclude input methods
-m17n*
-scim*
%end
