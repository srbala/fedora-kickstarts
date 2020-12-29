# Fedora Scientific with KDE Desktop

# Fedora Scientific: For researchers in Science and Engineering
# Fedora-Scientific aims to create a Fedora which has the generic
# toolset for the researcher
# Web: https://labs.fedoraproject.org/en/scientific/

# Maintainer: Amit Saha <amitksaha@fedoraproject.org>
#             https://fedoraproject.org/wiki/User:Amitksaha

%include fedora-live-kde-base.ks
%include fedora-live-minimization.ks
%include fedora-scientific-common.ks

# The recommended part size for DVDs is too close to use for the scientific spin
part / --size 15000

%post

%end
