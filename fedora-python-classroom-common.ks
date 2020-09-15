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
-pypy

# Remove LaTeX, see https://bugzilla.redhat.com/show_bug.cgi?id=1862450
-texlive-latex

%end
