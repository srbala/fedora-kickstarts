# fedora-livecd-kde-ja_JP.ks
#
# Description:
# - Japanese Fedora Live Spin with the KDE Desktop Environment
#
# Maintainer(s):
# - Shintaro Fujiwara <shintaro.fujiwara@miraclelinux.com>

%include ../fedora-live-kde.ks

lang ja_JP.UTF-8
keyboard jp
timezone Asia/Tokyo

%packages
langpacks-ja
# exclude input methods except ibus:
-m17n*
-scim*
-iok
# ibus-stuff 
fcitx-qt5
ibus-kkc
ibus-mozc
ibus-qt
kcm-fcitx
%end

%post
cat > /etc/X11/xorg.conf.d/00-keyboard.conf << "EOF"
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "jp"
        Option "XkbModel" "jp106"
EndSection
EOF
%end
