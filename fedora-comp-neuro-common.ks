# Description: Packages for the NeuroFedora computational neuroscience lab image.
# 
# Maintained by the NeuroFedora SIG:
# https://fedoraproject.org/wiki/SIGs/NeuroFedora
# mailto:neuro-sig@lists.fedoraproject.org

%packages

# Includes numpy, scipy, jupyter, pandas, scikit, scipy, statsmodels, sympy, matplotlib
@python-science

#Computational neuroscience packages
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
neurord
octave
paraview
python3
python3-brian2
python-brian2-doc
python3-ipython
python3-nest
python3-neuron
python3-libNeuroML
python3-neo
# Currently broken in rawhide
# python3-nineml
# python-nineml-doc
python3-PyLEMS
python-PyLEMS-doc
smoldyn

%end
