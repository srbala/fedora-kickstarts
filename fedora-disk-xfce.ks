%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-xfce-common.ks

bootloader --append="cma=192MB"

services --enabled=sshd,NetworkManager,chronyd,zram-swap

autopart --type=plain --noswap

%packages

%end

%post

%end
