# fedora-livedvd-games-de_DE.ks
#
# Maintainer(s):
# - Fabian Affolter <fab a fedoraproject.org>

%include ../fedora-livedvd-games.ks

lang de_DE.UTF-8
keyboard de-latin1-nodeadkeys
timezone Europe/Berlin

%packages
langpacks-de
# exclude input methods
-m17n*
-scim*
%end
