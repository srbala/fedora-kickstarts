%include fedora-arm-base.ks
%include fedora-arm-xbase.ks
%include fedora-lxqt-common.ks

%packages
# trojita not available on non-x86 platforms
-trojita
%end

%post
echo -n "Enabling initial-setup gui mode on startup"
ln -s /usr/lib/systemd/system/initial-setup-graphical.service /etc/systemd/system/graphical.target.wants/initial-setup-graphical.service
echo .

%end
