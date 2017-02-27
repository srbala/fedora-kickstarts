# Like the Python Classroom image, but tuned for vagrant.

%include fedora-cloud-base-vagrant.ks

%packages
@python-classroom

# Remove Pythons possibly recommended by tox
-python26
-python33
-python34
-python35
-pypy

%end
