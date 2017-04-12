%include fedora-disk-base.ks
%include fedora-disk-xbase.ks
%include fedora-workstation-common.ks

bootloader --append="cma=256MB"

%packages
-initial-setup
-initial-setup-gui

%end

%post

%end
