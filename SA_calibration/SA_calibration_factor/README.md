# Sulphuric Acid Calibration Factor

This folder contains tools to compute the sulfuric acid calibration factor by comparing modeled sulfuric acid concentrations with sulfuric acid signals measured during the calibration experiment.

It includes:
- **Matlab scripts**
  - `calculate_sa_calibration_factor.m`
  - `avg_from_fig.m`
- **Jupyter notebook**
  - `calculate_sa_calibration_factor.ipynb`

The calibration factor is derived using modeled sulfuric acid concentrations from `SA_calibration_model/` and calibration experiment data processed with:
- **TofTools** (Matlab workflow)
- **Tofware** (https://www.tofwerk.com/software/tofware/) (Python/Jupyter workflow)

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.
