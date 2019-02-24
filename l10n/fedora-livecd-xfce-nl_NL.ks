# fedora-livecd-xfce-nl_NL.ks
#
# Maintainer(s):
# - Jeroen van Meeuwen <kanarip a fedoraunity.org>

%include ../fedora-live-xfce.ks

lang nl_NL
keyboard us
timezone Europe/Amsterdam

%packages
langpacks-nl
# exclude input methods
-m17n*
-scim*
%end
