# Description: Packages for the NeuroFedora computational neuroscience lab image.
#
# Maintained by the NeuroFedora SIG:
# https://neuro.fedoraproject.org
# mailto:neuro-sig@lists.fedoraproject.org

%packages
fedora-release-compneuro
# Includes numpy, scipy, jupyter, pandas, scikit, scipy, statsmodels, sympy, matplotlib
@python-science

#Computational neuroscience packages
arbor
auryn-mpich
auryn-openmpi
bionetgen
calcium-calculator
COPASI
qalculate
getdp
genesis-simulator
gnuplot
moose
nest
neuron
neuron-devel
octave
paraview
python3
python3-brian2
python3-ipython
python3-nest
python3-netpyne
python3-neuron
python3-libNeuroML
python3-neo
python3-PyLEMS
python3-pynn
python3-steps
smoldyn

# Orphaned
# python3-nineml

%end
