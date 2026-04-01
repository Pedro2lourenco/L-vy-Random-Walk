# Lévy Walk Simulation and Analysis

This project simulates a random walk with step lengths following a Lévy distribution (heavy-tailed) and analyzes the resulting diffusion behavior. The simulation is written in R, and the analysis is performed in Python.

## 📋 Overview

A particle moves in a 2D plane confined within a circle of radius 2. The step directions are uniformly distributed in `[0, 2π)`, and the step lengths follow a power‑law distribution (Lévy distribution). Steps that would leave the confinement circle are rejected, keeping the particle at its previous position.

### Simulation Parameters

| Parameter | Description | Value |
|-----------|-------------|-------|
| $a$ | Lévy exponent (`2*runif(1)` gives a random value in `(0,2]`) | random |
| $d$ | Scale factor for step lengths | 0.1 |
| $N$ | Number of steps | 200 |
| Confinement radius | Maximum distance from origin | 2 |

## 🔧 Code Structure

### 1. Simulation (R) – `levy_simulation.R`

The R script generates the walk and produces a plot and a data file.

**Key features:**
- Generates step lengths using the inverse transform method: $dx = d * (U^(-1/a)) * cos(θ)$, $dy = d * (U^(-1/a)) * sin(θ)$, where `U ~ Uniform(0,1)`, `θ ~ Uniform(0,2π)`.
- Implements a reflective‑like boundary condition: steps that would go outside the circle of radius 2 are ignored.
- Outputs:
  - `Traj_levy.dat`: tab‑separated file with `X` and `Y` coordinates of each step.
  - `levy_plot.png`: plot of the trajectory (800×800 pixels) with the confinement circle shown as a red dashed line.

**Plot styling:**
- Black line for the trajectory.
- Red dashed circle for the boundary.
- Proper axes and aspect ratio.

### 2. Analysis (Python) – `levy_analysis.py`

The Python script loads the generated trajectory, computes the mean‑square displacement (MSD), and fits a linear model to determine the diffusion regime.

**Steps performed:**
1. Load the data from `Traj_levy.dat`.
2. Compute `R² = X² + Y²` (squared displacement) for each step.
3. Fit a linear regression: `R² ~ t`, where `t` is the step index.
4. Calculate the diffusion coefficient as `slope / 4`.
5. Classify the diffusion type based on the slope:

| Slope condition | Diffusion type |
|-----------------|----------------|
| `slope ≤ 0` or `0 < slope < 1` | Subdiffusive |
| `slope ≈ 1` (within tolerance) | Normal (simple) diffusion |
| `slope > 1` | Superdiffusive |

## 🚀 How to Run

### Prerequisites

- **R**: No additional packages are required (base R is sufficient).
- **Python**: Install the required libraries:
  ```bash
  pip install numpy matplotlib scikit-learn
  ```
