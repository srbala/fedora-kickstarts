# Description: The Workstation based NeuroFedora computational neuroscience lab image.
# https://fedoraproject.org/wiki/Changes/Comp_Neuro_Lab
#
# Maintained by the NeuroFedora SIG:
# https://neuro.fedoraproject.org
# mailto:neuro-sig@lists.fedoraproject.org

%include fedora-live-workstation.ks
%include fedora-comp-neuro-common.ks
%include fedora-neuro-gnome-common.ks

part / --size 10240
