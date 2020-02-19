# fedora-livecd-soas.ks
#
# Description:
# - A Sugar environment that you can carry in your pocket
#
# Maintainers:
# - Peter Robinson <pbrobinson AT gmail DOT com>

firewall --enabled --service=mdns,presence

%packages

# == Core Sugar Platform ==
@sugar-desktop

# explicitly remove a bunch of extra stuff
-openbox
-@fonts
-@dial-up
-@multimedia
-@printing
-foomatic
-@gnome-desktop 
-yp-tools
-ypbind
-rdate
-rdist
-icedtea-web
-firefox
-glx-utils
-nmap-ncat
-PackageKit
-eekboard-libs
-open-vm-tools*
-gfs2-utils
-abrt-cli
-ibus*
-hyperv-daemons
-sane-backends
-sane-backends-drivers-scanners

# Add some extra fonts
dejavu-sans-fonts
dejavu-sans-mono-fonts
madan-fonts
aajohan-comfortaa-fonts
sil-abyssinica-fonts
vlgothic-fonts

# Write breaks unless we do this (we don't need it anyway)
@input-methods

# Needed for wifi, bluetooth and WWAN connection support
@networkmanager-submodules

# Usefulness for DSL connections as per:
# http://bugs.sugarlabs.org/ticket/1951
rp-pppoe

# Useful for SoaS duplication from:
# http://bugs.sugarlabs.org/ticket/74
livecd-tools

# Get the Sugar boot screen
-plymouth-system-theme
-plymouth-theme-charge

%end

%post

# Get proper release naming in the control panel
cat >> /boot/olpc_build << EOF
Sugar on a Stick
EOF
cat /etc/fedora-release >> /boot/olpc_build

# Rebuild initrd for Sugar boot screen
KERNEL_VERSION=$(rpm -q kernel --qf '%{version}-%{release}.%{arch}\n')
/usr/sbin/plymouth-set-default-theme sugar
dracut -N -f /boot/initramfs-$KERNEL_VERSION.img $KERNEL_VERSION

# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/sugar
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# Don't use the default system user (in SoaS liveuser) as nick name
# Disable the logout menu item in Sugar
# Enable Sugar power management
cat >/usr/share/glib-2.0/schemas/sugar.soas.gschema.override <<EOF
[org.sugarlabs.user]
default-nick='disabled'

[org.sugarlabs]
show-logout=false

[org.sugarlabs.power]
automatic=true
EOF
/usr/bin/glib-compile-schemas /usr/share/glib-2.0/schemas

%end
