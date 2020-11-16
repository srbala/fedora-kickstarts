# fedora-lxqt-common.ks
#
# Description:
# – Fedora Live Spin with the LXQt desktop environment
#
# Maintainer(s):
# – Christian Dersch <lupinix@fedoraproject.org>
# – Zamir SUN <zsun@fedoraproject.org>
#

%packages
# install env-group to resolve RhBug:1891500
@^lxqt-desktop-environment

@lxqt-apps
@lxqt-media

# for nm applet
gnome-keyring


# l10n
@lxqt-l10n
lximage-qt-l10n
obconf-qt-l10n
pavucontrol-qt-l10n

# MP3
gstreamer1-plugin-mpg123

# Text Editor
enki

# remove unneeded stuff to get a lightweight system
# fonts (we make no bones about admitting we're english-only)
wqy-microhei-fonts          # a compact CJK font, to replace:
-naver-nanum-gothic-fonts       # Korean
-vlgothic-fonts             # Japanese
-adobe-source-han-sans-cn-fonts     # simplified Chinese
-adobe-source-han-sans-tw-fonts     # traditional Chinese

-pt-sans-fonts # Cyrillic (already supported by DejaVu), huge
#-stix-fonts        # mathematical symbols

# remove input methods to free space
-@input-methods
-@admin-tools
-scim*
-m17n*
# Temporary include ibus to workaround RHBZ 1633225
# -ibus*
-iok

# Fix https://bugzilla.redhat.com/show_bug.cgi?id=1429132
# Why is this not pulled in by anaconda???
storaged

%end

