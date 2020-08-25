%packages
fedora-release-matecompiz
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

# blacklist applications which breaks mate-desktop
-audacious

# office
@libreoffice

# dsl tools
rp-pppoe

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# Drop things for size
-@3d-printing
-brasero
-fedora-icon-theme
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-logs
-gnome-software
-gnome-user-docs

-@mate-applications

# Help and art can be big, too
-gnome-user-docs
-evolution-help

# Legacy cmdline things we don't want
-telnet

%end
