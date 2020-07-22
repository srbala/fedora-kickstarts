# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# The Workstion based Python Classroom Lab

%include fedora-live-workstation.ks
%include fedora-python-classroom-gnome-common.ks

# https://bugzilla.redhat.com/show_bug.cgi?id=1695796
part / --size 8192
