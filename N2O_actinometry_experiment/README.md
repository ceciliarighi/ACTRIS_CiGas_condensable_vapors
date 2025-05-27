# It-product

This folder contains scripts and documentation for determining the It‑product (photon flux) required as input parameter for SA calibration models. 

## Contents
- **N2O_actinometry.m** (Matlab) and **It_factor.ipynb** (Python notebook):
  - Compute the non-corrected It‑product.
  - Calculate the geometry correction factor K for each N₂O concentration step and applies it to yield the corrected It‑product.
- **It_factor_correction.ipynb** (Python notebook):
  - Computes the geometry correction factor K for each N₂O concentration step.
  - Assumes the non-corrected It‑product has been calculated elsewhere (e.g., in Excel) and calculates K to correct it.

## Usage
- **N2O_actinometry.m**
  - Open **N2O_actinometry.m** in Matlab.
  - Update the input arrays and constants under *%% User interface*.
  - Run each section in order to:
    1) Compute the non-corrected It‑product.
    2) Calculate the geometry correction factor K.
    3) Compute the corrected It‑product.
- **It_factor.ipynb**
  - Launch Jupyter and open **It_factor.ipynb**.
  - Update the input arrays and constants under *## user interface*.
  - Run all cells in order to:
    1) Compute the non-corrected It‑product.
    2) Calculate the geometry correction factor K.
    3) Compute the corrected It‑product.
- **It_factor_correction.ipynb**
  - Launch Jupyter and open **It_factor_correction.ipynb**.
  - Update the input arrays and constants under *## user interface*.
  - Run the cells in order to calculate the geometry correction facor K.

>[!TIP]
>For detailed theoretical background and script differences, see **N2O_actinometry_experiment_guidelines.pdf**.

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.










