#! /usr/bin/env bash

# Install pre-requisites (python 2.7)
sudo apt-get install git qtwebengine5-dev libqt5svg5-dev emacs libboost-all-dev cmake g++ gfortran

# Download and build Mfront

set -e
# PREFIX=$HOME
PREFIX=/home/mfront
PYTHON_VERSION=2.7

export TFELSRC=$PREFIX/codes/tfel/master/src
export TFELPLOTSRC=$PREFIX/codes/tfel-plot/master/src
export TFELEDITORSRC=$PREFIX/codes/tfel-editor/master/src
export TFELBASEHOME=$PREFIX/codes/tfel/master
export TFELPLOTBASEHOME=$PREFIX/codes/tfel-plot/master
export TFELEDITORBASEHOME=$PREFIX/codes/tfel-editor/master

mkdir -p $TFELSRC
mkdir -p $TFELPLOTSRC
mkdir -p $TFELEDITORSRC

pushd $TFELSRC
if [ -d tfel ]
then
	pushd tfel
	git pull
	popd 
else
	git clone https://github.com/thelfer/tfel.git
fi
popd

pushd $TFELPLOTSRC
if [ -d tfel-plot ]
then
	pushd tfel-plot
	git pull
	popd 
else
	git clone https://github.com/thelfer/tfel-plot.git
fi
popd

pushd $TFELEDITORSRC
if [ -d tfel-editor ]
then
	pushd tfel-editor
	git pull
	popd 
else
	git clone https://github.com/thelfer/tfel-editor.git
fi
popd

tfel_rev=$(cd $TFELSRC/tfel;git rev-parse HEAD)
tfel_plot_rev=$(cd $TFELPLOTSRC/tfel-plot;git rev-parse HEAD)
tfel_editor_rev=$(cd $TFELEDITORSRC/tfel-editor;git rev-parse HEAD)

export TFELHOME=$TFELBASEHOME/install-${tfel_rev}
export TFELPLOTHOME=$TFELPLOTBASEHOME/install-${tfel_plot_rev}
export TFELEDITORHOME=$TFELEDITORBASEHOME/install-${tfel_editor_rev}

pushd $TFELBASEHOME
tfel_previous=$(ls -1dtr install-* | tail -1)
tfel_previous_rev=${tfel_previous#install-}
popd

echo "tfel current  revision : $tfel_rev" 
echo "tfel previous revision : $tfel_previous_rev" 
if [ 1==1 ]; #[ x"$tfel_previous_rev" != x"$tfel_rev" ];
then
  pushd $TFELSRC
  ### Update to a working commit for SM2018
  pushd tfel
  git checkout a785e41 
  popd
  ###
  mkdir -p build
  pushd build
  cmake ../tfel -DCMAKE_BUILD_TYPE=Release -Dlocal-castem-header=ON -Denable-aster=ON -Denable-abaqus=ON -Denable-calculix=ON -Denable-ansys=ON -Denable-europlexus=ON -Denable-python=ON -Denable-python-bindings=ON -DPython_ADDITIONAL_VERSIONS=$PYTHON_VERSION -DCMAKE_INSTALL_PREFIX=$TFELHOME

  make
  make install
  popd
  popd
  
  cat >> ${TFELHOME}/env.sh <<EOF
  export TFELHOME=${TFELHOME}
  export PATH=${TFELHOME}/bin:\$PATH
  export LD_LIBRARY_PATH=${TFELHOME}/lib:\$LD_LIBRARY_PATH
  export PYTHONPATH=${TFELHOME}/lib/python${PYTHON_VERSION}/site-packages/:\$PYTHONPATH
  export PYTHONPATH=${TFELHOME}/lib/python${PYTHON_VERSION}m/site-packages/:\$PYTHONPATH
EOF
  
  pushd $TFELBASEHOME
  count=$(ls -1d install-* | wc -l)
  if (( $count > 4 )) ; then 
    find . -maxdepth 1 -ctime +60 -name "install-*" -exec rm -rf {} \;
  fi
  last=$(ls -1dtr install-* | tail -1)
  ln -nsf "${last}" install
fi

source ${TFELHOME}/env.sh

echo "source ${TFELHOME}/env.sh" >> ~/.bashrc
. ~/.bashrc

#### NOTES ON RUNNING MFRONT
# Use Salome Meca 2018 with correct LD_LIBRARY_PATH
# ~/salome_meca/appli_V2018.0.1_public/salome shell
# . ~/.bashrc #This loads the correct MFront env (assuming you modded the library path in ~/.bashrc)
# as_run case.export
