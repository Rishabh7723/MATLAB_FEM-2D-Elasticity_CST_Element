# FEM-2D-Elasticity-MATLAB

## 📌 Overview

This project implements a **2D Finite Element Method (FEM) solver** in MATLAB for linear elasticity problems using **Constant Strain Triangle (CST) elements**. It supports **plane stress and plane strain analysis** and demonstrates the response of a uniformly loaded rectangular bar.

---

## ⚙️ Features

* 2D FEM solver for linear elasticity
* CST (triangular) elements
* Plane stress and plane strain formulations
* Mesh generation (DistMesh / structured)
* Global stiffness assembly
* Body force and traction loading
* Dirichlet boundary conditions
* Modular utility functions for reuse
* Post-processing of displacement and stress

---

## 📐 Governing Equation

[
\nabla \cdot \sigma + b = 0
]

Weak form:

[
K u = F
]

---

## 🧮 Element Formulation

* **Element:** Constant Strain Triangle (CST)
* Linear displacement → constant strain

[
K_e = t A (B^T D B)
]

---

## 🏗️ Project Structure

```text
FEM-2D-Elasticity-MATLAB/
│
├── main.m                  # Main driver script
├── bilinear.m              # Element stiffness (CST)
├── domain.m                # Mesh generation
├── linear_body.m           # Body force vector
├── linear_point.m          # Traction load
├── properties.m            # Stress & displacement post-processing
├── params.m                # Problem parameters
├── rectTriMesh.m           # Structured mesh generator
├── triBoundaryEdges.m      # Boundary detection
├── solveLinearSystem.m     # Solver
││
├── utils/                        # Reusable helper functions
│   ├── gaussQuadrature.m        # Numerical integration
│   ├── plotField.m              # 1D field plotting
│   ├── shapeFunctions1D.m       # Linear shape functions
│   ├── shapeFunctionsHermiteBeam1D.m  # Beam interpolation (Hermite)
│   └── solveLinearSystem.m      # Linear solver utility
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## ▶️ How to Run

1. Open MATLAB
2. Navigate to project folder
3. Run:

```matlab
main
```

---

## 📊 Output

* Nodal displacements ((u_x, u_y))
* Stress components ((\sigma_{xx}, \sigma_{yy}, \tau_{xy}))
* Deformed mesh visualization
* FEM vs analytical comparison

---

## 🧪 Validation

For a uniform bar under axial load:

[
\sigma_{xx} = \frac{P}{tW}
]

---

## ⚠️ Notes

* Transverse deformation occurs due to **Poisson’s effect**
* Over-constrained boundary conditions can introduce artificial bending
* Mesh quality affects solution accuracy

---

## 🚀 Future Improvements

* Quadrilateral (Q4) elements
* Nonlinear FEM
* Dynamic analysis
* Adaptive mesh refinement

---

## 👨‍💻 Author

**Rishabh Shukla**

---

## 📜 License

MIT License
