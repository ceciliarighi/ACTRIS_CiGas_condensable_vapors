# Sulphuric Acid Calibration Model

This folder contains Matlab functions and scripts for sulphuric acid calibration modeling. 

## Contents
- **vappresw.m**: Computes saturation vapor pressure of water (Pa) at a given temperature (K) according to Preining (1981).
- **diff_sa_rh.m**: Calculates the diffusion coefficient of sulphuric acid, accounting for relative humidity (RH).
- **gormleyKennedy.m**: Implements the Gormley–Kennedy approximation for mean collection efficiency in a tubular flow system.
- **odesolveMatlab.m**: Internal ODE solver for the full flow model, transcribed from a University of Helsinki C implementation.
- **cmd_calib1Matlab.m**: Returns the mean weighted sulphuric acid concentration for given environmental and instrument parameters. Supports both simple (Gormley–Kennedy) and full flow models.
- **Input_parameters.m**: Example parameter set. Defines temperature, pressure, tube dimensions, flows, and model options. Runs cmd_calib1Matlab over a range of water flows and plots results.

## Usage
- Place all files in the same directory.
- Open Matlab and change the working directory to this folder.
- Edit **Input_parameters.m**:
    - Set temperature (T), pressure (p), tube inner diameter (ID), tube length (L), inlet flow rate (Q), It-factor at Q (It), sulphur dioxide concentration in the tank (SO2BottlePpm) and model type (fullOrSimpleModel).
    - Adjust gas flow rates (N2Flow, AirFlow, WaterFlow, SO2Flow) as needed.
- Run **Input_parameters.m** to:
    - Call cmd_calib1Matlab for each water flow value.
    - Display plots of concentration profiles and calibration curves.
    - Return the output vectors H2Oconc, H2SO4, O2conc, SO2conc, and totFlow. Each vector has one entry per step in WaterFlow (e.g., five steps → five values per vector).

>[!NOTE]
>Feel free to open an issue or submit a pull request for improvements, bug reports, or feature requests.


## Other Resources
A Python-based calibration model is available at [momo-catcat/MARFORCE-flowtube](https://github.com/momo-catcat/MARFORCE-flowtube). Comprehensive usage instructions and model details are provided in that repository.

Currently, the Matlab-based and Python-based calibration models differ in their outputs: 
- The Matlab-based model returns the **mass flow rate of sulphuric acid** exiting the inlet tube.
- The Python-based model calculates the **average sulphuric acid concentration** at the final segment of the tube.

To easily appreciate the difference between the two approaches, imagine the inlet tube divided into a fixed number of
concentric cells. The Matlab-based model calculates the sum of each cell’s sulphuric acid concentration multiplied by its area and local flow rate. In contrast, the Python-based model multiplies the concentration in each cell by its area only and computes the average across all cells.

>[!IMPORTANT]
>In order to have consistent data, ACTRIS recommends reporting modelled sulphuric acid concentrations as mass flow rates for each step of the calibration experiment.

