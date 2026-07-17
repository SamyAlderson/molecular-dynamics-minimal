# Design Document: molecular-dynamics-minimal

## Overview
A minimal molecular dynamics simulation in Julia for educational purposes.

## Architecture
- `src/main.jl` - Entry point and simulation loop
- `src/molecules.jl` - Molecular structure definitions
- `src/forces.jl` - Force field calculations (Lennard-Jones)
- `src/integrator.jl` - Velocity Verlet integration
- `src/utils.jl` - Utility functions

## Choix techniques
- Langage: Julia (performance + simplicité)
- Intégrateur: Velocity Verlet (stabilité symplectique)

## Améliorations futures
- Potentiels multiples (Coulomb, etc.)
- Parallélisation GPU
- Visualisation 3D
