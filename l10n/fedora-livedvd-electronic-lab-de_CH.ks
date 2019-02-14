# fedora-livecd-electronic-lab-de_CH.ks
#
# Maintainer(s):
# - Fabian Affolter <fab a fedoraproject.org>

%include ../fedora-livedvd-electronic-lab.ks

lang de_DE
keyboard sg-latin1
timezone Europe/Zurich

%packages
langpacks-de
# exclude input methods
-m17n*
-scim*
%end
