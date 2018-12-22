%include fedora-arm-base.ks
%include fedora-minimal-common.ks

part /boot --size=512 --fstype ext4
part / --size=1300 --fstype ext4

%packages
-xkeyboard-config
%end
