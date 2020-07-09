%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-workstation-common.ks

bootloader --append="cma=256MB"

services --enabled=sshd,NetworkManager,chronyd

autopart --type=btrfs --noswap

%packages
-initial-setup
-initial-setup-gui

%end

%post

%end
