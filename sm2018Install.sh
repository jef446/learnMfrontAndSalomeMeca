#! /usr/bin/env bash

# Install pre-requisites (python 2.7)
sudo apt-get install  gfortran g++ python-dev python-numpy liblapack-dev libblas-dev tcl tk zlib1g-dev bison flex checkinstall openmpi-bin libx11-dev cmake grace gettext libboost-all-dev swig
sudo apt-get install libsuperlu-dev

# Download and install SM2018
pushd ~/Downloads
wget -O sm2018.tgz https://www.code-aster.org/FICHIERS/salome_meca-2018.0.1-LGPL-1.tgz
tar -xzvf sm2018.tgz
rm sm2018.tgz
./salome_meca-2018.0.1-LGPL-1.run 
rm salome_meca-2018.0.1-LGPL-1.run 
popd

# Fix libs
pushd ~/salome_meca/V2018.0.1_public/prerequisites/debianForSalome/lib/
mv    libstdc++.so  libstdc++.so_
mv  libstdc++.so.6  libstdc++.so.6_
mv  libstdc++.so.6.0.20  libstdc++.so.6.0.20_
popd


#### NOTES ON RUNNING MFRONT
# Use Salome Meca 2018 with correct LD_LIBRARY_PATH
# ~/salome_meca/appli_V2018.0.1_public/salome shell
# . ~/.bashrc #This loads the correct MFront env (assuming you modded the library path in ~/.bashrc)
# as_run case.export
