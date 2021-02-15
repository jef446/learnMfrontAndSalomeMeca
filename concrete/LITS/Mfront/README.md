# Building an mfront behaviour law

## Step 0 - Install Mfront. Instructions [here](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/mfrontInstall.sh)

## Step 1 - Write a behaviour law
An example is provided [here](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/concrete/LITS/Mfront/LoadInducedThermalStrain_Torelli2018_uniaxial.mfront)

## Step 2 - Compile shared library from the behaviour law
Enter the following commands in terminal:

``CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0 `tfel-config --compiler-flags --oflags`" mfront --obuild --interface=aster LoadInducedThermalStrain_Torelli2018_uniaxial.mfront``

Note that this command will generate ./src/libAsterBehaviour.so

