# fedora-design-suite.ks
# Based on Live Workstation
# Description:
# - A collection of applications targeted towards professional visual designers
# Website: http://fedoraproject.org/wiki/Design_Suite
# Maintainer:
# - Luya Tshimbalanga <luya AT fedoraproject DOT org>
# - Credit to Sebastian Dziallas for initiating the project

%include fedora-live-workstation.ks

# Size partition
part / --size 14336

%packages
# Switch to groups for design suite
@design-suite

# Provides backup application
deja-dup
deja-dup-nautilus

# Add extra gnome applications
gnome-books
gnome-calendar
gnome-photos
gnome-shell-extension-pomodoro
gnome-todo

# Add cosmetic for gnome-terminal
powerline
powerline-fonts

# Extra wallpapers
f31-backgrounds-extras-gnome

# removal of unneeded applications
-gnome-boxes
-eog
-rdesktop

# temporarily removing conflicting application
-mypaint
-sparkleshare

%end

%post
#Override the favorite desktop application in Dash
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'shotwell.desktop', 'gimp.desktop', 'darktable.desktop','krita.desktop', 'inkscape.desktop', 'blender.desktop', 'libreoffice-writer.desktop', 'scribus.desktop', 'pitivi.desktop', 'nautilus.desktop', 'bijiben.desktop', 'anaconda.desktop', 'list-design-tutorials.desktop']
FOE

# Add link to lists of tutorials
cat >> /usr/share/applications/list-design-tutorials.desktop << FOE
[Desktop Entry]
Name=List of design tutorials
GenericName=List of Tutorials for Designers
Comment=Reference of Design Related Tutorials
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite/Tutorials
Type=Application
Icon=applications-graphics
Categories=Graphics;Documentation;
FOE
chmod a+x /usr/share/applications/list-design-tutorials.desktop

# Add information about Fedora Design Suite
cat >> /usr/share/applications/fedora-design-suite.desktop << FOE
[Desktop Entry]
Name=Design Suite Info
GenericName=About Design Suite
Comment=Wiki page of Design Suite
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-suite.desktop

# Add information about Fedora Design Team
cat >> /usr/share/applications/fedora-design-team.desktop << FOE
[Desktop Entry]
Name=Design Team Info
GenericName=About Design Team 
Comment=Wiki page of Design Team
Exec=xdg-open https://fedoraproject.org/wiki/Design
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-team.desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
