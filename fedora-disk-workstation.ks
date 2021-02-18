%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-workstation-common.ks

autopart --type=btrfs --noswap

%packages
-initial-setup
-initial-setup-gui

%end
