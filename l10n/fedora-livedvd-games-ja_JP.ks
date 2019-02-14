# fedora-livedvd-games-ja_JP.ks
#
# Description:
# - Japanese Fedora Live Spin with the game Desktop Environment
# 
# Maintainer(s):
# - Mika Tsukada  <mika.tsukada@miraclelinux.com>

%include ../fedora-live-games.ks

lang ja_JP.UTF-8
keyboard ja
timezone Asia/Tokyo

%packages
langpacks-ja
# exclude input methods except ibus:
-m17n*
-scim*
-iok
glibc-langpack-ja
# ibus-stuff
ibus-kkc
ibus-mozc
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


