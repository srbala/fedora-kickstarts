%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-soas-common.ks

part btrfs.007 --fstype="btrfs" --size=3400
btrfs none --label=fedora btrfs.007
btrfs /home --subvol --name=home LABEL=fedora
btrfs / --subvol --name=root LABEL=fedora

%post

%end
