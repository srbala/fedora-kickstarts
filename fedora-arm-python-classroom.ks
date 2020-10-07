# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# The ARM Workstion based Python Classroom Lab

%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-workstation-common.ks
%include fedora-python-classroom-gnome-common.ks

part btrfs.007 --fstype="btrfs" --size=7000
btrfs none --label=fedora btrfs.007
btrfs /home --subvol --name=home LABEL=fedora
btrfs / --subvol --name=root LABEL=fedora

%packages
-initial-setup
-initial-setup-gui
-libvirt*
-gnome-boxes

%end

%post
# Most of the ARM X accelerated drivers need some level of CMA allocation
sed -i 's/\(append .*\)/\1 cma=256MB/' /boot/extlinux/extlinux.conf

%end

