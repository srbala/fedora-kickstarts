# fedora-livecd-xfce-de_CH.ks
#
# Maintainer(s):
# - Fabian Affolter <fab at fedoraproject.org>

%include ../fedora-live-xfce.ks

lang de_DE
keyboard sg-latin1-nodeadkeys
timezone Europe/Zurich

%packages
langpacks-de
# exclude input methods
-m17n*
-scim*
%end
