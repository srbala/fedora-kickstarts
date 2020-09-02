# This is a basic Fedora cloud spin designed to work in OpenStack and other
# private cloud environments. It's configured with cloud-init so it will
# take advantage of ec2-compatible metadata services for provisioning ssh
# keys. Cloud-init creates a user account named "fedora" with passwordless
# sudo access. The root password is empty and locked by default.
#
# This kickstart file is designed to be used with ImageFactory (in Koji).
#
# To do a local build, you'll need to install ImageFactory.  See
# http://worknotes.readthedocs.org/en/latest/cloudimages.html for some notes.
#
# For a TDL file, I store one here:
# https://pagure.io/fedora-atomic/raw/master/f/fedora-atomic-rawhide.tdl
# (Koji generates one internally...what we really want is Koji to publish it statically)
#
# Once you have imagefactory and imagefactory-plugins installed, run:
#
#   curl -O https://pagure.io/fedora-atomic/raw/master/f/fedora-atomic-rawhide.tdl
#   tempfile=$(mktemp --suffix=.ks)
#   ksflatten -v F22 -c fedora-cloud-base.ks > ${tempfile}
#   imagefactory --debug base_image --file-parameter install_script ${tempfile} fedora-atomic-rawhide.tdl
#

text # don't use cmdline -- https://github.com/rhinstaller/anaconda/issues/931
lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC

selinux --enforcing
rootpw --lock --iscrypted locked

firewall --disabled

# We pass net.ifnames=0 because we always want to use eth0 here on all the cloud images.
bootloader --timeout=1 --append="no_timer_check net.ifnames=0 console=tty1 console=ttyS0,115200n8"

services --enabled=sshd,cloud-init,cloud-init-local,cloud-config,cloud-final

zerombr
clearpart --all
autopart --noboot --nohome --noswap --nolvm

%include fedora-repo.ks

reboot

##### begin package list #############################################
%packages --instLangs=en

# Include packages for the cloud-server-environment group
@^cloud-server-environment

# Don't include the kernel toplevel package since it pulls in
# kernel-modules. We're happy for now with kernel-core.
-kernel
kernel-core

# Don't include dracut-config-rescue. It will have dracut generate a
# "rescue" entry in the grub menu, but that also means there is a
# rescue kernel and initramfs that get created, which (currently) add
# about another 40MiB to the /boot/ partition. Also the "rescue" mode
# is generally not useful in the cloud.
-dracut-config-rescue

# Plymouth provides a graphical boot animation. In the cloud we don't
# need a graphical boot animation. This also means anaconda won't put
# rhgb/quiet on kernel command line
-plymouth

# No need for firewalld for now. We don't have a firewall on by default.
-firewalld

# noswap on Cloud for now
-zram-generator-defaults
%end
##### end package list ###############################################


##### begin kickstart post ###########################################
%post --erroronfail

# linux-firmware is installed by default and is quite large. As of mid 2020:
#   Total download size: 97 M
#   Installed size: 268 M
# So far we've been fine shipping without it so let's continue.
# More discussion about this in #1234504.
echo "Removing linux-firmware package."
rpm -e linux-firmware

# See the systemd-random-seed.service man page that says:
#   " It is recommended to remove the random seed from OS images intended
#     for replication on multiple systems"
echo "Removing random-seed so it's not the same in every image."
rm -f /var/lib/systemd/random-seed

echo "Import RPM GPG key"
releasever=$(rpm --eval '%{fedora}')
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

echo "Zeroing out empty space."
# This forces the filesystem to reclaim space from deleted files
dd bs=1M if=/dev/zero of=/var/tmp/zeros || :
rm -f /var/tmp/zeros
echo "(Don't worry -- that out-of-space error was expected.)"

# When we build the image a networking config file gets left behind.
# Let's clean it up.
echo "Cleanup leftover networking configuration"
rm -f /etc/NetworkManager/system-connections/*.nmconnection

# Clear machine-id on pre generated images
truncate -s 0 /etc/machine-id

%end
##### end kickstart post ############################################
