# fedora-livecd-xfce-ru_RU.ks
#
# Maintainer(s):
# - Sergey Mihailov <sergey.mihailov at gmail.com>

%include ../fedora-live-xfce.ks

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

%packages
langpacks-ru
hunspell-ru

# exclude input methods
-m17n*
-scim*
%end
