# fedora-livecd-i3.ks
#
# Description:
# - Fedora Live Spin with the tiling window manager i3wm
#
# Maintainer(s):
# - Nasir Hussain    <nasirhm@fedoraproject.org>
# - Eduard Lucena    <x3mboy@fedoraproject.org>
# - Justin W. Flory  <jwf@fedoraproject.org>
# - Dan Cermak       <defolos@fedoraproject.org>


%packages

@networkmanager-submodules
i3
dunst
azote
lightdm-gtk
brightlight
feh
mousepad
dex-autostart
network-manager-applet
pavucontrol
volumeicon
thunar
lightdm-gtk


# unlock default keyring. FIXME: Should probably be done in comps
gnome-keyring-pam
# Admin tools are handy to have
@admin-tools
wget
# Better more popular browser
firefox
system-config-printer

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-aspell-*                   # dictionaries are big

%end
