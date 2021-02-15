# Building an mfront behaviour law

## Step 0 - Install Mfront. Instructions [here](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/mfrontInstall.sh)

## Step 1 - Write a behaviour law
An example is provided [here](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/concrete/LITS/Mfront/LoadInducedThermalStrain_Torelli2018_uniaxial.mfront)

## Step 2 - Compile shared library from the behaviour law
Enter the following commands in terminal:

``CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0 `tfel-config --compiler-flags --oflags`" mfront --obuild --interface=aster LoadInducedThermalStrain_Torelli2018_uniaxial.mfront``

Note that this command will generate ./src/libAsterBehaviour.so

## Step 3 - Run you simulation referencing the behaviour law and the shared library
Note that the shared library is referenced on [line 19](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/concrete/LITS/HC.comm) and the name of the behaviour law is reference on [line 21](https://github.com/jef446/learnMfrontAndSalomeMeca/blob/main/concrete/LITS/HC.comm)

To run a simulation with code_aster using the Salome_Meca platform:

1. start a salome shell session: `pathToSalome/salome shell`
1. Open astk: `astk &`
1. Import simulation settings: File>Import .export 
1. Run simulation
