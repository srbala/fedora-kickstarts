%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-soas-common.ks

autopart --type=btrfs --noswap
