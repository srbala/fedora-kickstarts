# This is a minimal Fedora install designed to serve as a Docker base image.
#
# To keep this image minimal it only installs English language. You need to change
# dnf configuration in order to enable other languages.
#
###  Hacking on this image ###
# This kickstart is processed using Anaconda-in-ImageFactory (via Koji typically),
# but you can run imagefactory locally too.
#
# To do so, testing local changes, first you'll need a TDL file.  I store one here:
# https://git.fedorahosted.org/cgit/fedora-atomic.git/tree/fedora-atomic-rawhide.tdl
#
# Then, once you have imagefactory and imagefactory-plugins installed, run:
#
#   imagefactory --debug target_image --template /path/to/fedora-atomic-rawhide.tdl --parameter offline_icicle true --file-parameter install_script $(pwd)/fedora-docker-base.ks docker
#

text # don't use cmdline -- https://github.com/rhinstaller/anaconda/issues/931
bootloader --disabled
timezone --isUtc --nontp Etc/UTC
rootpw --lock --iscrypted locked

keyboard us
network --bootproto=dhcp --device=link --activate --onboot=on
reboot

zerombr
clearpart --all
part /boot/efi --fstype="vfat" --size=100
part / --fstype ext4 --grow

%packages --excludedocs --instLangs=en --nocore --excludeWeakdeps
bash
fedora-release
microdnf
-kernel
-e2fsprogs
-libss # used by e2fsprogs
-fuse-libs


%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

# Set install langs macro so that new rpms that get installed will
# only install langs that we limit it to.
LANG="en_US"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf

# https://bugzilla.redhat.com/show_bug.cgi?id=1400682
echo "Import RPM GPG key"
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-primary

echo "# fstab intentionally empty for containers" > /etc/fstab

# Remove machine-id on pre generated images
rm -fv /etc/machine-id
touch /etc/machine-id

# remove some random help txt files
rm -fv usr/share/gnupg/help*.txt

# Pruning random things
rm usr/lib/rpm/rpm.daily
rm -rfv usr/lib64/nss/unsupported-tools/  # unsupported

# Statically linked crap
rm -fv usr/sbin/{glibc_post_upgrade.x86_64,sln}
ln usr/bin/ln usr/sbin/sln

# Remove some dnf info
rm -rfv /var/lib/dnf

# don't need icons
rm -rfv /usr/share/icons/*

#some random not-that-useful binaries
rm -fv /usr/bin/pinky

# we lose presets by removing /usr/lib/systemd but we do not care
rm -rfv /usr/lib/systemd

# if you want to change the timezone, bind-mount it from the host or reinstall tzdata
rm -fv /etc/localtime
mv /usr/share/zoneinfo/UTC /etc/localtime
rm -rfv  /usr/share/zoneinfo

# Final pruning
rm -rfv var/cache/* var/log/* tmp/*

%end

%post --nochroot --erroronfail --log=/mnt/sysimage/root/anaconda-post-nochroot.log
set -eux

# https://bugzilla.redhat.com/show_bug.cgi?id=1343138
# Fix /run/lock breakage since it's not tmpfs in docker
# This unmounts /run (tmpfs) and then recreates the files
# in the /run directory on the root filesystem of the container
# NOTE: run this in nochroot because "umount" does not exist in chroot
umount /mnt/sysimage/run
# The file that specifies the /run/lock tmpfile is
# /usr/lib/tmpfiles.d/legacy.conf, which is part of the systemd
# rpm that isn't included in this image. We'll create the /run/lock
# file here manually with the settings from legacy.conf
# NOTE: chroot to run "install" because it is not in anaconda env
chroot /mnt/sysimage install -d /run/lock -m 0755 -o root -g root


# See: https://bugzilla.redhat.com/show_bug.cgi?id=1051816
# NOTE: run this in nochroot because "find" does not exist in chroot
KEEPLANG=en_US
for dir in locale i18n; do
    find /mnt/sysimage/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rfv {} +
done

%end
