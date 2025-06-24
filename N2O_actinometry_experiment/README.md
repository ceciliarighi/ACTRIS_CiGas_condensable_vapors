# It-product

This folder contains scripts and documentation for determining the It‑product (photon flux) required as input parameter for SA calibration models. 

## Contents
- **It_product_calc_template.m** (Matlab):
  - Takes into account the NOx monitor detection limit.
  - Compute the non-corrected It‑product.
  - Calculate the geometry correction factor K for each N₂O concentration step and applies it to yield the corrected It‑product.
- **It_factor.m** (Matlab) and **It_factor.ipynb** (Python notebook):
  - Compute the non-corrected It‑product.
  - Calculate the geometry correction factor K for each N₂O concentration step and applies it to yield the corrected It‑product.
- **It_factor_correction.ipynb** (Python notebook):
  - Computes the geometry correction factor K for each N₂O concentration step.
  - Assumes the non-corrected It‑product has been calculated elsewhere and calculates K to correct it.

## Usage
- **It_product_calc_template.m**
  - Open **It_product_calc_template.m** in Matlab.
  - Update the input arrays and constants under *%% parameter input*.
  - Run each section in order to:
    1) Remove background levels and values below the detection limit.
    2) Compute the non-corrected It‑product.
    3) Calculate the geometry correction factor K.
    4) Compute the corrected It‑product.
- **It_factor.m**
  - Open **It_factor.m** in Matlab.
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

[!IMPORTANT]
Be sure to apply the geometry correction factor K as described in Appendix A of [Kürten *et al.* (2012)](https://pubs.acs.org/doi/10.1021/jp212123n), regardless of which script you use.

>[!TIP]
>For detailed theoretical background and script differences, see **N2O_actinometry_experiment_guidelines.pdf**.

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.










