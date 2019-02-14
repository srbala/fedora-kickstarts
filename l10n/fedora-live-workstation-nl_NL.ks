# fedora-live-workstation-nl_NL.ks
#
# Maintainer(s):
# - Jeroen van Meeuwen <kanarip a fedoraunity.org>

%include ../fedora-live-workstation.ks

lang nl_NL.UTF-8
keyboard us
timezone Europe/Amsterdam

%packages
langpacks-nl
# exclude input methods
-m17n*
-scim*
%end
