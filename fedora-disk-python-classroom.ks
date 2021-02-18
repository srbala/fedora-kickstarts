# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# The Workstion based Python Classroom Lab

%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-workstation-common.ks
%include fedora-python-classroom-gnome-common.ks

autopart --type=btrfs --noswap

%packages
-initial-setup
-initial-setup-gui
-libvirt*
-gnome-boxes

%end
