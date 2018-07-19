%include fedora-disk-base.ks
%include fedora-minimal-common.ks

services --enabled=sshd,NetworkManager,chronyd,initial-setup,zram-swap

autopart --type=plain --noswap

%packages
-xkeyboard-config
%end
