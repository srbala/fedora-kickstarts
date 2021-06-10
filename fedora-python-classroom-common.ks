# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# Common packages of all Python Classroom images

%packages
@python-classroom
@python-science
nano
openssh-clients
vim-enhanced
wget

# Remove Pythons possibly recommended by tox
-python2
-python26
-python27
-python33
-python34
-python35
-python36
-python37
-python38
-python2.7
-python3.5
-python3.6
-python3.7
-python3.8
-python3.9
-pypy

# Remove LaTeX, see https://bugzilla.redhat.com/show_bug.cgi?id=1862450
#               and https://bugzilla.redhat.com/show_bug.cgi?id=1902354
-texlive-base
-texlive-latex

# Remove gdal recommended by networkx, brings in close to 600M of proj data
# Also explicitly list proj to make sure both packages are gone
# https://lists.fedoraproject.org/archives/list/python-devel@lists.fedoraproject.org/thread/LGC5IMMHZ4DM7GQNPAFC6GU362PPTN7O/
-python3-gdal
-proj

%end
