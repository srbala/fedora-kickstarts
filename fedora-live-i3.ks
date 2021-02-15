# fedora-livecd-i3.ks
#
# Description:
# - Fedora Live Spin with the tiling window manager i3
#
# Maintainer(s):
# - Nasir Hussain    <nasirhm@fedoraproject.org>
# - Eduard Lucena    <x3mboy@fedoraproject.org>
# - Dan Cermak       <defolos@tummy.com>
# - Justin W. Flory  <jwf@fedoraproject.org>

%include fedora-live-base-not-rawhide.ks
%include fedora-live-minimization.ks
%include fedora-i3-common.ks

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/i3
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set i3 as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=i3/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

# setting the wallpaper
echo "/usr/bin/feh --bg-scale /usr/share/backgrounds/default.png" >> /home/liveuser/.profile

# echoing type liveinst to start the installer
echo "echo 'Please type liveinst and press Enter to start the installer'" >> /home/liveuser/.bashrc

# fixing the installer non opening bug
echo "xhost si:localuser:root" >> /home/liveuser/.profile

EOF

%end

