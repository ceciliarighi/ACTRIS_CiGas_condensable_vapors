# Sulphuric Acid Calibration Factor

This folder contains Matlab scripts and functions to derive the sulfuric acid calibration factor by comparing modeled sulphuric acid concentrations (see SA_calibration_model/) to measured CIMS signals. 

## Contents
- **average_from_fig.m**:
  - It prompts for start/end times via ginput.
  - It computes the average of each trace.
  - It returns a matrix of y_avg_all signals.
- **sa_meas.m**:
  - Reads time and sa_conc arrays (normalized SA signal).
  - Plots the time series of sa_conc.
  - Calls average_from_fig to compute y_avg_1 (and y_avg_2 if present).

  >[!NOTE]
  >After running, save y_avg_1 (and y_avg_2) into your model MAT‑file from Input_parameters.m (see SA_calibration_model/).

- **sa_calibration_factor_calculation.m**:
  - Loads the model MAT‑file containing H2Oconc, H2SO4, y_avg_1 (and y_avg_2).
  - Plots modelled and measured SA signals on dual axes for each calibration.
  - Calculates step‑wise calibration factors C = H2SO4 ./ y_avg_i and derives mean_C and std_C.
  - Performs linear regressions (H₂SO₄ = m × y_avg_i) to obtain slope‑based calibration factors for each calibration.

## Usage
- Use **sa_meas.m** to extract the CIMS signal for each step of the calibration.
- Use **sa_calibration_factor_calculation.m** to calculate the mean calibration factor.

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.
