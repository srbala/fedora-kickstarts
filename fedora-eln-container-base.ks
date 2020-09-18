# See fedora-container-common.ks for details on how to hack on container image kickstarts
# This base is a standard Fedora-ELN image with python3 and dnf

text
lang en_US.UTF-8
keyboard us
timezone --utc America/New_York
# add console and reorder in %post
bootloader --timeout=1 --location=mbr --append="console=ttyS0,115200n8 no_timer_check crashkernel=auto net.ifnames=0"
auth --enableshadow --passalgo=sha512
selinux --enforcing
firewall --enabled --service=ssh
network --bootproto=dhcp --device=link --activate --onboot=on
#services --enabled=sshd,ovirt-guest-agent --disabled kdump,rhsmcertd
services --enabled=sshd,NetworkManager,cloud-init,cloud-init-local,cloud-config,cloud-final,rngd --disabled kdump,rhsmcertd
rootpw --iscrypted nope

#
# Partition Information. Change this as necessary
# This information is used by appliance-tools but
# not by the livecd tools.
#
zerombr
clearpart --all --initlabel
# autopart --type=plain --nohome # --nohome doesn't work because of rhbz#1509350
# autopart is problematic in that it creates /boot and swap partitions rhbz#1542510 rhbz#1673094
reqpart
part / --fstype="xfs" --ondisk=vda --size=8000
reboot

%packages --excludedocs --instLangs=en --nocore --excludeWeakdeps
fedora-release-container
bash
coreutils
glibc-minimal-langpack
rpm
shadow-utils
sssd-client
util-linux
-kernel
-dosfstools
-e2fsprogs
-fuse-libs
-gnupg2-smime
-libss # used by e2fsprogs
-pinentry
-shared-mime-info
-trousers
-xkeyboard-config
-grubby

rootfiles
# https://communityblog.fedoraproject.org/modularity-dead-long-live-modularity/
fedora-repos-modular
tar # https://bugzilla.redhat.com/show_bug.cgi?id=1409920
vim-minimal
dnf
yum  # DNF compatibility with yum
sssd-client
sudo
-glibc-langpack-en
-cracklib-dicts
-langpacks-en
%end

%post --erroronfail --log=/root/anaconda-post.log
# remove some extraneous files
rm -rf /var/cache/dnf/*
rm -rf /tmp/*

# https://pagure.io/atomic-wg/issue/308
printf "tsflags=nodocs\n" >>/etc/dnf/dnf.conf


# https://bugzilla.redhat.com/show_bug.cgi?id=1343138
# Fix /run/lock breakage since it's not tmpfs in docker
# This unmounts /run (tmpfs) and then recreates the files
# in the /run directory on the root filesystem of the container
#
# We ignore the return code of the systemd-tmpfiles command because
# at this point we have already removed the /etc/machine-id and all
# tmpfiles lines with %m in them will fail and cause a bad return
# code. Example failure:
#   [/usr/lib/tmpfiles.d/systemd.conf:26] Failed to replace specifiers: /run/log/journal/%m
#
umount /run
rm /run/nologin # https://pagure.io/atomic-wg/issue/316

# Final pruning
rm -rfv /var/cache/* /var/log/* /tmp/*

%end

%post --nochroot --erroronfail --log=/mnt/sysimage/root/anaconda-post-nochroot.log
set -eux

# Set install langs macro so that new rpms that get installed will
# only install langs that we limit it to.
LANG="en_US"
echo "%_install_langs $LANG" > /etc/rpm/macros.image-language-conf

# https://bugzilla.redhat.com/show_bug.cgi?id=1727489
echo 'LANG="C.UTF-8"' >  /etc/locale.conf

# https://bugzilla.redhat.com/show_bug.cgi?id=1400682
echo "Import RPM GPG key"
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-34-primary

echo "# fstab intentionally empty for containers" > /etc/fstab

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

# See: https://bugzilla.redhat.com/show_bug.cgi?id=1051816
# NOTE: run this in nochroot because "find" does not exist in chroot
KEEPLANG=en_US
for dir in locale i18n; do
    find /mnt/sysimage/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rfv {} +
done

%end
