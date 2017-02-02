# fedora-livecd-lxde-ja_JP.ks
#
# Description:
# - Japanese Fedora Live Spin with the LXDE Desktop Environment
#
# Maintainer(s):
# - Shintaro Fujiwara <shintaro.fujiwara@miraclelinux.com>

%include ../fedora-live-lxde.ks

lang ja_JP.UTF-8
keyboard jp
timezone Asia/Tokyo

%packages
@japanese-support
# exclude input methods:
-m17n*
-scim*
-ibus*
-iok
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

