%% Sulfuric Acid Calibration for CI-APi-TOF
%
% Author: Cecilia Righi
% Last update: March 2026
%
% Description:
% This script determines the calibration factor of a CI-APi-TOF instrument
% using sulfuric acid calibration experiment data together with modeled
% sulfuric acid concentrations.
%
% The workflow includes:
%   1. Load previously preprocessed CI-APi-TOF data from the calibration experiment.
%   2. Compute the normalized sulfuric acid signal (SH2SO4).
%   3. Calculate the average SH2SO4 value for each calibration step.
%   4. Load previously modeled H2SO4 concentrations ([H2SO4]_modeled).
%   5. Determe the calibration factor as:
%        - C_avg: the average of the calibration factor calculated for each step
%        - C_lin: the slope of the linear regression [H2SO4]_modeled = f(SH2SO4)


%% ------------------------------------------------------------------------
% 1. Load previously preprocessed CI-APi-TOF data

toftoolPath = 'C:\LocalData\ceciliar\OneDrive - University of Helsinki\Documents\tofTools613\'; % path to TofTools package
addpath (toftoolPath);

tof_gui_eval_params

fNam = 'example_path\example_experiment.h5'; % path to preprocessed HDF5 file
plNam = 'example_path\example_peakList.db'; % path to peaklist
tb = tof_get_HR_timeseries_peaklist(fNam, plNam);


%% ------------------------------------------------------------------------
% 2. Compute the normalized sulfuric acid signal (SH2SO4)
% ------------------------------------------------------------------------

% ---- Simplified equation (A) ----
num_A = tb.("HSO4-") + tb.("HNO3HSO4-");
den_A = tb.("NO3-")  + tb.("HNO3NO3-") + tb.("H2ONO3-");
tb.SH2SO4_A = num_A ./ den_A;
tb.SH2SO4_A(den_A <= 0) = NaN;

% ---- Complete equation (B) ----
num_B = tb.("HSO4-") + tb.("HNO3HSO4-") + tb.("H2SO4HSO4-") + tb.("(H2SO4)2HSO4-");
den_B = tb.("NO3-")  + tb.("HNO3NO3-")  + tb.("(HNO3)2NO3-") + tb.("H2ONO3-");
tb.SH2SO4_B = num_B ./ den_B;
tb.SH2SO4_B(den_B <= 0) = NaN;

figure(1)
plot(tb.tmd, tb.SH2SO4_A, 'LineWidth', 2, 'Color', 'blue')
hold on
plot(tb.tmd, tb.SH2SO4_B, 'LineWidth', 2, 'Color', 'red')
ylabel('SH2SO4')
xlabel('Time')
legend('Equation A','Equation B','Location','northwest')


%% ------------------------------------------------------------------------
% 3. Extract average SH2SO4 values for each calibration step
% ------------------------------------------------------------------------
% The user manually selects the time intervals corresponding to each
% calibration step in the time series plot.
%
% The function avg_from_fig calculates the average SH2SO4 signal within
% each selected interval.

figure(2)
plot(tb.tmd, tb.SH2SO4_B, 'LineWidth', 2, 'Color', 'red')
ylabel('SH2SO4')
xlabel('Time')
legend('Equation B','Location','northwest')

avg_from_fig(tb.tmd, tb.SH2SO4_B)


%% ------------------------------------------------------------------------
% 4. Load previously modeled H2SO4 concentrations
% ------------------------------------------------------------------------

modelPath = 'example_path\';
modelData = load(fullfile(modelPath, 'model_file_name.mat'));

% Extract relevant variables from model output
H2Oconc = modelData.H2Oconc;
H2SO4   = modelData.H2SO4;

% NOTE:
% If multiple calibrations contain a different number of steps,
% subsets of H2Oconc and H2SO4 need to be defined.


%% ------------------------------------------------------------------------
% 5a. Determine the calibration factor (single calibration)
% ------------------------------------------------------------------------

figure(3)
ax1 = axes;
yyaxis left
scatter(H2Oconc, H2SO4, 50, 'o', 'LineWidth', 2, 'MarkerEdgeColor', 'red')
xlabel('[H2O] modeled, cm^{-3}');
ylabel('[H2SO4] modeled, cm^{-3}');
title('[H2SO4] modeled vs SH2SO4')
pause(0.1)
ax1.XTickMode = 'manual';
ax1.YTickMode = 'manual';
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)];
ax1.XLimMode = 'manual';
grid(ax1,'on')
yyaxis right
scatter(H2Oconc, y_avg_cal_1, 70, 'x', 'LineWidth', 2, 'MarkerEdgeColor', 'red')
ylabel('SH2SO4');
legend('[H2SO4] modeled, cm^{-3}', 'SH2SO4', 'Location','Southeast')
ax1.YAxis(1).Color = 'k';
ax1.YAxis(2).Color = 'k';

% C_avg
C_avg = H2SO4 ./ y_avg_cal_1;
mean_C_avg = mean(C_avg);
std_C_avg  = std(C_avg);
figure(4)
scatter(H2SO4,C_avg,'Linewidth',1.5,'MarkerEdgeColor','red')
xlabel('[H2SO4] modeled, cm^{-3}')
ylabel('Calibration factor, cm^{-3}')
ylim([0, max(C_avg)+3e9])
hold on
plot([0, max(H2SO4)+0.5e8], [mean_C_avg,mean_C_avg], 'k--', 'LineWidth', 1.5)
hold on
errorbar(max(H2SO4)+0.5e8, mean_C_avg, std_C_avg, 'k.', 'LineWidth', 1.5)
legend('Calibration data','Mean calibration factor', 'Std calibration factor','Location','Southwest')
text(max(H2SO4)+0.5e8, mean_C_avg, sprintf(' C = %.2e', mean_C_avg), ...
     'VerticalAlignment', 'bottom', ...
     'HorizontalAlignment', 'right', ...
     'FontSize', 18, ...
     'Color', 'black')

% C_lin
coeffs = polyfit(y_avg_cal_1, H2SO4, 1);
C_lin = coeffs(1);
fitline = polyval(coeffs, y_avg_cal_1);
figure(5)
scatter(y_avg_cal_1, H2SO4, 'filled', 'MarkerFaceColor', 'red');
hold on
plot(y_avg_cal_1, fitline, 'k--', 'LineWidth', 1.5);
xlabel('SH2SO4')
ylabel('[H2SO4] modeled, cm^{-3}')
legend('Calibration data', ...
       sprintf('Linear fit: C = %.2e', C_lin), ...
       'Location', 'Northwest')
grid on


%% ------------------------------------------------------------------------
% 5b. Determine the calibration factor (two calibrations)
% ------------------------------------------------------------------------

figure(3)
ax1 = axes;
yyaxis left
scatter(H2Oconc, H2SO4, 50, 'o', 'LineWidth', 2, 'MarkerEdgeColor', 'red')
xlabel('[H2O] modeled, cm^{-3}');
ylabel('[H2SO4] modeled, cm^{-3}');
title('[H2SO4] modeled vs SH2SO4')
pause(0.1)
ax1.XTickMode = 'manual';
ax1.YTickMode = 'manual';
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)];
ax1.XLimMode = 'manual';
grid(ax1,'on')
yyaxis right
scatter(H2Oconc, y_avg_cal_1, 70, 'x', 'LineWidth', 2, 'MarkerEdgeColor', 'red')
ylabel('SH2SO4');
legend('[H2SO4] modeled, cm^{-3}', 'SH2SO4', 'Location','Southeast')
ax1.YAxis(1).Color = 'k';
ax1.YAxis(2).Color = 'k';
figure(4)
ax1 = axes;
yyaxis left
scatter(H2Oconc, H2SO4, 50, 'o', 'LineWidth', 2, 'MarkerEdgeColor', '#FF8800')
xlabel('[H2O] modeled, cm^{-3}');
ylabel('[H2SO4] modeled, cm^{-3}');
title('[H2SO4] modeled vs SH2SO4')
pause(0.1)
ax1.XTickMode = 'manual';
ax1.YTickMode = 'manual';
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)];
ax1.XLimMode = 'manual';
grid(ax1,'on')
yyaxis right
scatter(H2Oconc, y_avg_cal_2, 70, 'x', 'LineWidth', 2, 'MarkerEdgeColor', '#FF8800')
ylabel('SH2SO4');
legend('[H2SO4] modeled, cm^{-3}', 'SH2SO4', 'Location','Southeast')
ax1.YAxis(1).Color = 'k';
ax1.YAxis(2).Color = 'k';

% C_avg
C_avg_1 = H2SO4 ./ y_avg_cal_1
C_avg_2 = H2SO4 ./ y_avg_cal_2
C_avg = vertcat(C_avg_1,C_avg_2)
mean_C_avg = mean(C_avg)
std_C_avg = std(C_avg)
figure(5)
scatter(H2SO4,C_avg_1,'Linewidth',1.5,'MarkerEdgeColor','red')
hold on, scatter(H2SO4,C_avg_2,'Linewidth',1.5,'MarkerEdgeColor','#FF8800')
xlabel('[H2SO4] modeled, cm^{-3}'); 
ylabel('Calibration factor, cm^{-3}'); 
ylim([0, max(C_avg)+3e9])
hold on, plot([0, max(H2SO4)+0.5e8], [mean_C_avg,mean_C_avg], 'k--', 'LineWidth', 1.5)
hold on, errorbar(max(H2SO4)+0.5e8, mean_C_avg, std_C_avg, 'k.', 'LineWidth', 1.5)
legend('Calibration 1 data','Calibration 2 data', 'Mean calibration factor', 'Std calibration factor','Location','Southwest') 
text(max(H2SO4)+0.5e8, mean_C_avg, sprintf(' C = %.2e', mean_C_avg), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 18, 'Color', 'black') 
grid on

% C_lin
coeffs1 = polyfit(y_avg_cal_1, H2SO4, 1)
C_lin_1 = coeffs1(1)
fit1 = polyval(coeffs1, y_avg_cal_1)
coeffs2 = polyfit(y_avg_cal_2, H2SO4, 1)
C_lin_2 = coeffs2(1)
fit2 = polyval(coeffs2, y_avg_cal_2)
mean_C_lin = mean([C_lin_1, C_lin_2])
figure(6)
h1 = scatter(y_avg_cal_1, H2SO4, 'filled', 'MarkerFaceColor', 'red')
hold on
h2 = plot(y_avg_cal_1, fit1, 'r--', 'LineWidth', 1.5)
h3 = scatter(y_avg_cal_2, H2SO4, 'filled', 'MarkerFaceColor', '#FF8800')
h4 = plot(y_avg_cal_2, fit2, 'y--', 'LineWidth', 1.5)
h5 = plot(nan, nan, 'k:')
xlabel('SH2SO4')
ylabel('[H2SO4] modeled, cm^{-3}')
legend([h1, h2, h3, h4, h5], ...
       'Calibration 1 data', sprintf('C1 = %.2e', C_lin_1), ...
       'Calibration 2 data', sprintf('C2 = %.2e', C_lin_2), ...
       sprintf('C = %.2e', mean_C_lin), ...
       'Location', 'Northwest')
grid on
