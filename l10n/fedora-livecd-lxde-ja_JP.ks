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
# exclude input methods except ibus:
-m17n*
-scim*
-iok
# Better more popular browser
firefox
# ibus stuff
ibus-kkc
imsettings
%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
#### setting env and start ibus-deamon ####
#mkdir /home/liveuser
cat >> /home/liveuser/.bash_profile << FOE
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx
FOE
#### autostart ibus and stuff ####
cat > /etc/xdg/autostart/imsettings-start.desktop << "FOE"
[Desktop Entry]
Encoding=UTF-8
Type=Application
Version=1.0
Name=Input Method starter
Name[ja]=入力メソッドのスターター
Exec=imsettings-switch -n -q -x
Terminal=false
FOE
EOF
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
