# It-product

This folder contains scripts and documentation for determining the It‑product (photon flux) required as input parameter for sulfuric acid calibration model. 

## Contents
- **It_factor.m** (Matlab) and **It_factor.ipynb** (Jupiter Notebook):
  --> These scripts output the mean and median values of both the uncorrected and geometry-corrected It-product, scaled to the total flow rate used during the sulfuric acid calibration experiment.

- **It_factor_correction.ipynb** (Jupiter Notebook):
  --> This script outputs the geometry correction factor (K) for each step of the N₂O actinometry experiment.

- **example_sheet.xlsx** (Excel Spreadsheet):
  --> This spreadsheet provides a template for processing N₂O actinometry data. It outputs the mean and median values of both the uncorrected and geometry-corrected It-product for the total flow rate used during the actinometry experiment (7.5 lpm), as well as for a total flow rate of 10 lpm. The geometry correction factor K must first be calculated separately using It_factor_correction.ipynb and then entered into the spreadsheet.


>[!IMPORTANT]
>In order to have consistent data, ACTRIS recommends to apply the geometry correction factor K as described in Appendix A of [Kürten *et al.* (2012)](https://pubs.acs.org/doi/10.1021/jp212123n).

>[!TIP]
>For detailed theoretical background and guidelines on the N2O actinometry experiment, see **ACTRIS_CiGas_UHEL_N2Oactinometry_guidelines.pdf**.

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.










