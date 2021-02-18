%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-kde-common.ks

autopart --type=btrfs --noswap
