%include fedora-arm-base.ks
%include fedora-minimal-common.ks

part /boot --size=512 --fstype ext4
part swap --size=256 --fstype swap
part / --size=1200 --fstype ext4
