# Running code_aster FE simulations with MFront behaviour laws

## Step 0 - Decide what you want to simulate
As analyst, you should decide what it is you wish to model. In the example here, we choose to model the high temperature behaviour of concrete under uniaxial constraint [Section 3.1](https://www.sciencedirect.com/science/article/pii/S0020768316303456)

## Step 1 - Create Command file and mesh
To run an FE simulation you need a mesh, that represents your physical domain. You will obtain nodal solutions of physical properties on your domain, and estimate these quantities elsewhere via elemental shape functions, e.g. compute displacement at nodes and estimate elemental stresses.

You need to create a set of commands that will tell your FE solver how to model your scenario. This will cover aspects like the resolution method and criteria, e.g. Newton algorithm with acceptable error limits.

Happily, to support you getting started, this folder contains:
* .comm file for code_aster solver
* .export file indicating code_aster solver settings
* .mmed file is a code_aster mesh
