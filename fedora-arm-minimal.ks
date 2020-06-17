%include fedora-arm-base.ks
%include fedora-minimal-common.ks

part / --size=1500 --fstype ext4

%packages
-xkeyboard-config
%end
