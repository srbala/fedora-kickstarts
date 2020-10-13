text
lang en_US.UTF-8
keyboard us
timezone US/Eastern
selinux --enforcing
# Disabled for modular compose (for now)
#firewall --enabled --service=mdns
# Disabled for modular compose (for now)
#services --enabled=sshd,chronyd,initial-setup
services --enabled=NetworkManager
network --bootproto=dhcp --device=link --activate
rootpw --lock --iscrypted locked
shutdown

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8"

zerombr
clearpart --all --initlabel --disklabel=msdos
autopart --type=plain

# make sure that initial-setup runs and lets us do all the configuration bits
firstboot --reconfig

%include fedora-repo.ks

%packages --excludedocs --excludeWeakdeps --nocore
bash
fedora-modular-release
filesystem
coreutils-single
util-linux
rpm
shadow-utils
microdnf
glibc-minimal-langpack
grubby
kernel
sssd-client
@networkmanager-submodules
-fedora-logos
-coreutils
-dosfstools
-e2fsprogs
-fuse-libs
-gnupg2-smime
-libss # used by e2fsprogs
-libusbx
-pinentry
-shared-mime-info
-trousers
-xkeyboard-config
-dracut
%end

%post

# Find the architecture we are on
arch=$(uname -m)

# Setup Raspberry Pi firmware
if [[ $arch == "aarch64" ]] || [[ $arch == "armv7l" ]]; then
if [[ $arch == "aarch64" ]]; then
cp -P /usr/share/uboot/rpi_3/u-boot.bin /boot/efi/rpi3-u-boot.bin
cp -P /usr/share/uboot/rpi_4/u-boot.bin /boot/efi/rpi4-u-boot.bin
else
cp -P /usr/share/uboot/rpi_2/u-boot.bin /boot/efi/rpi2-u-boot.bin
cp -P /usr/share/uboot/rpi_3_32b/u-boot.bin /boot/efi/rpi3-u-boot.bin
cp -P /usr/share/uboot/rpi_4_32b/u-boot.bin /boot/efi/rpi4-u-boot.bin
fi
fi

releasever=$(rpm --eval '%{fedora}')
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-primary
echo "Packages within this disk image"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' |sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
/sbin/chkconfig network off

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end
