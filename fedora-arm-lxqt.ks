%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-lxqt-common.ks

part btrfs.007 --fstype="btrfs" --size=4400
btrfs none --label=fedora btrfs.007
btrfs /home --subvol --name=home LABEL=fedora
btrfs / --subvol --name=root LABEL=fedora

%packages
# trojita not available on non-x86 platforms
-trojita
%end

%post

%end
