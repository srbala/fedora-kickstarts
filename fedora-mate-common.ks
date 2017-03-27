%packages
-PackageKit*                # we switched to yumex, so we don't need this
PackageKit-command-not-found  # nifty for installing not-found cli-commands
firefox
@mate
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-experimental
libcompizconfig
compiz-plugins-main
ccsm
simple-ccsm
emerald-themes
emerald
fusion-icon
@networkmanager-submodules
blueberry

# some apps from mate-applications
caja-actions
mate-disk-usage-analyzer

# more backgrounds
f26-backgrounds-base
f26-backgrounds-mate
f26-backgrounds-extras-base

# system tools
system-config-printer
system-config-printer-applet
lightdm-gtk-greeter-settings

# audio video
parole
exaile
gstreamer1-plugin-mpg123  # mp3 support

# blacklist applications which breaks mate-desktop
-audacious

# office
@libreoffice

# dsl tools
rp-pppoe

# some tools
p7zip
p7zip-plugins

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# Drop things for size
-@3d-printing
-brasero
-colord
-fedora-icon-theme
-GConf2
-gnome-bluetooth-libs
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-software
-gnome-themes
-gnome-themes-standard
-gnome-user-docs

-@mate-applications
-mate-icon-theme-faenza

# Help and art can be big, too
-gnome-user-docs
-evolution-help

# Legacy cmdline things we don't want
-telnet

%end
