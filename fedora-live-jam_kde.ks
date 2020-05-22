#fedora-livedvd-jam-kde.ks
# With KDE Desktop

# Fedora Jam: For Musicians and audio enthusiasts
# Fedora Jam is a spin for anyone interested in creating 
# music 
# Web: https://fedoraproject.org/wiki/Fedora_jam
# Web: insert spinspacke when created

# Maintainer: Erich Eickmeyer <erich@ericheickmeyer.com>

%include fedora-live-kde.ks

# DVD size partition
part / --size 10240 --fstype ext4

#enable threaded irqs
bootloader --append="threadirqs"

%packages
@audio

#pipewire
pipewire

#sound analasys, none of these are packaged yet
#praat bug_id=666656
#friture

#writing & publishing
emacs
emacs-color-theme
vim
nano

#audio utilities

# fedora jam theming (to be customized)
fedora-jam-backgrounds
fedora-jam-kde-theme

#Misc. Utils
screen
multimedia-menus
kernel-tools


#Include Mozilla Firefox and Thunderbird
firefox
thunderbird

#remove packages not needed
-akregator
-kaddressbook
-kmail
-kontact
-korganizer
-non-mixer
-non-session-manager
-non-sequencer

%end

%post

#setup kickoff favorites
/bin/mkdir -p /etc/skel/.config

JAMFAVORITES=/usr/share/applications/firefox.desktop,/usr/share/applications/qjackctl.desktop,/usr/share/applications/ardour5.desktop,/usr/share/applications/carla.desktop,/usr/share/applications/org.kde.konsole.desktop,/usr/share/applications/org.kde.dolphin.desktop,/usr/share/applications/systemsettings.desktop,/usr/share/applications/org.kde.kontact.desktop
JAMFAVORITESLIVE=/usr/share/applications/liveinst.desktop,$JAMFAVORITES

cat <<EOF  >> /etc/skel/.config/kickoffrc
[Favorites]
FavoriteURLs=$JAMFAVORITES
EOF

# Override fedora-live-kde-base.ks settings
sed -i /etc/rc.d/init.d/livesys -res"#^(FavoriteURLs=).*#\1${JAMFAVORITESLIVE}#"


cat >> /etc/rc.d/init.d/livesys << EOF
/usr/sbin/usermod -a -G jackuser,audio liveuser
EOF

%end


