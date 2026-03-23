# Lab 4: 2D Uniform Bar (DistMesh + CST Triangles)

## Goal
Solve a 2D linear elasticity model of a uniform bar:
- Domain: rectangle `[0, L] x [-W/2, W/2]`
- Element: linear triangular (CST), 2 DOFs per node `(u_x, u_y)`
- Loading: uniform traction on `x = L` such that total force is `P`
- BC: `u_x = 0` on `x = 0`, and one `u_y` DOF is pinned to remove rigid motion

## DistMesh dependency
This version assumes you already have the original DistMesh repository on the MATLAB path.
It calls:
- `distmesh2d`
- `drectangle`
- `huniform`

The local `distmesh.m` file in this folder is not used by `domain.m`.

## Run
1. Add the original DistMesh repository to the MATLAB path.
2. Set MATLAB working directory to this folder.
3. Run:
```matlab
main
```

## Diagnostic check
When DistMesh is detected, `main.m` prints the resolved path of `distmesh2d`.

## Outputs
- Deformed mesh plot
- Triangle plot of `sigma_xx`
- Interpolated displacements at a few query points
