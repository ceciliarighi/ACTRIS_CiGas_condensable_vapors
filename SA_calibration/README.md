# Sulphuric Acid Calibration

This folder contains Matlab functions and scripts to model sulphuric acid concentrations for each step of a calibration experiment and to calculate the corresponding calibration factor by comparing modeled and measured values, according to [Kürten *et al.* (2012)](https://pubs.acs.org/doi/10.1021/jp212123n)

>[!NOTE]
>Ensure you know the It-product for your setup beforehand (see N2O_actinometry_experiment/).

## Folder Structure
1) ***SA_calibration_model/*** Contains scripts to compute modeled SA concentrations based on experimental conditions.
2) ***SA_calibration_factor/*** Contains scripts to extract the measured CIMS signals and calculate the calibration factor by comparing them to the modelled sulphuric acid concentrations.
