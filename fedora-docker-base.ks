# This is a minimal Fedora install designed to serve as a Docker base image.
#
# To keep this image minimal it only installs English language. You need to change
# yum configuration in order to enable other languages.
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

cmdline
bootloader --disabled
timezone --isUtc --nontp Etc/UTC
rootpw --lock --iscrypted locked

keyboard us
zerombr
clearpart --all
part / --fstype ext4 --grow
network --bootproto=dhcp --device=link --activate --onboot=on
reboot

%packages --excludedocs --instLangs=en --nocore
bash
tar # https://bugzilla.redhat.com/show_bug.cgi?id=1409920
fedora-release
rootfiles
vim-minimal
dnf
dnf-yum  # https://fedorahosted.org/fesco/ticket/1312#comment:29
sssd-client
#fakesystemd #TODO: waiting for review https://bugzilla.redhat.com/show_bug.cgi?id=1118740
-kernel


%end

%post --erroronfail --log=/root/anaconda-post.log
set -eux

# Set install langs macro so that new rpms that get installed will
# only install langs that we limit it to.
LANG="en_US"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf

echo "Import RPM GPG key"
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

echo "# fstab intentionally empty for containers" > /etc/fstab

# remove some extraneous files
rm -rf /var/cache/dnf/*
rm -rf /tmp/*

#Mask mount units and getty service so that we don't get login prompt
systemctl mask systemd-remount-fs.service dev-hugepages.mount sys-fs-fuse-connections.mount systemd-logind.service getty.target console-getty.service

# Fix /run/lock breakage since it's not tmpfs in docker
umount /run
systemd-tmpfiles --create --boot

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end
