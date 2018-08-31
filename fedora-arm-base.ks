lang en_US.UTF-8
#keyboard us
auth --useshadow --passalgo=sha512
selinux --enforcing
firewall --enabled --service=mdns,ssh

bootloader --location=mbr

part /boot/efi --size=80 --fstype vfat --asprimary
part /boot --size=512 --fstype ext4 --asprimary
part / --size=2800 --fstype ext4 --asprimary

# make sure that initial-setup runs and lets us do all the configuration bits
firstboot --reconfig

services --enabled=sshd,NetworkManager,avahi-daemon,chronyd,initial-setup,zram-swap

%include fedora-repo.ks

%packages
@core
@standard
@hardware-support
zram

kernel
# remove this in %post
dracut-config-generic
-dracut-config-rescue
# install tools needed to manage and boot arm systems
@arm-tools
-uboot-images-armv8
rng-tools
chrony
extlinux-bootloader
bcm283x-firmware
initial-setup
initial-setup-gui
-iwl*
-ipw*
-usb_modeswitch
-iproute-tc
#lets resize / on first boot
# dracut-modules-growroot

# make sure all the locales are available for inital0-setup and anaconda to work
glibc-all-langpacks

%end

%post

# Setup Raspberry Pi firmware
cp -P /usr/share/uboot/rpi_2/u-boot.bin /boot/efi/rpi2-u-boot.bin
cp -P /usr/share/uboot/rpi_3_32b/u-boot.bin /boot/efi/rpi3-u-boot.bin

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
basearch=armhfp
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
echo "Packages within this ARM disk image"
rpm -qa
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# Because memory is scarce resource in most arm systems we are differing from the Fedora
# default of having /tmp on tmpfs.
echo "Disabling tmpfs for /tmp."
systemctl mask tmp.mount

dnf -y remove dracut-config-generic

# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
/sbin/chkconfig network off

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end

