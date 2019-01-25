%include fedora-arm-base.ks
%include fedora-minimal-common.ks

part / --size=1400 --fstype ext4

%packages
-xkeyboard-config
%end
