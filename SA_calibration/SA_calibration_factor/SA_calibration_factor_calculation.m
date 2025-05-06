%% SA calibration factor
% Cecilia Righi 

%% Load model data

% model that has been obtained running Input_parameters.m and updated with
% y_avg_1 (and y_avg_2)
modelPath = 'C:\LocalData\ceciliar\OneDrive - University of Helsinki\Documents\PhD\2024 ACTRIS CIMS intercomparison campaign\sa_calibration\'; % path of the model.mat file
modelData = load(fullfile(modelPath, 'model_CYI.mat')); 

% Access model variables 
H2Oconc = modelData.H2Oconc; 
H2SO4 = modelData.H2SO4; 
y_avg_1 = modelData.y_avg_1; % Calibration #1
y_avg_2 = modelData.y_avg_2; % Calibration #2

%% Calculate SA calibration factor (cm-3) - 1 calibration

% Compare SA modelled and SA measured  
figure 
ax1 = axes 
yyaxis left 
scatter(H2Oconc,H2SO4,'Linewidth',1.5,'MarkerEdgeColor','blue')  
xlabel('[H2O] modelled, cm-3'); 
ylabel('[H2SO4] modelled, cm-3'); 
title('y_1')
pause(0.1) 
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'manual'; 
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)]; 
ax1.XLimMode = 'manual'; 
grid(ax1,'on') 
ytick = ax1.YTick; 
yyaxis right 
scatter(H2Oconc,y_avg_1, 'Linewidth',1.5,'MarkerEdgeColor','red') 
ylabel('CIMS signal');  
legend('[H2SO4] modelled, cm-3 (left axis)','CIMS signal (right axis)','Location','Southeast') 

% Calculate mean calibration factor  
C = H2SO4 ./ y_avg_1; 
mean_C = mean(C); 
std_C = std(C); 
figure 
scatter(H2SO4,C,'Linewidth',1.5,'MarkerEdgeColor','blue') 
xlabel('[H2SO4] modelled, cm-3')
ylabel('Calibration factor, cm-3') 
ylim([0, max(C)+3e9]) 
title('SA calibration')
hold on 
plot([0, max(H2SO4)+0.5e8], [mean_C,mean_C], 'k--', 'LineWidth', 1.5)
hold on 
errorbar(max(H2SO4)+0.5e8, mean_C, std_C, 'k.', 'LineWidth', 1.5)
legend('Calibration 1','Mean calibration factor', 'Standard deviation calibration factor','Location','Northwest') 
text(max(H2SO4)+0.5e8, mean_C, sprintf(' Mean = %.2e', mean_C), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 18, 'Color', 'black')

%% Calculate SA calibration factor as slope of linear fit - 1 calibration

% Linear fit: H2SO4 = m * CIMS signal
coeffs = polyfit(y_avg_1, H2SO4, 1); % coeffs(1) is the slope m
m = coeffs(1);
fitline = polyval(coeffs, y_avg_1);

% Plot
figure;
scatter(y_avg_1, H2SO4, 'filled', 'MarkerFaceColor', 'blue');
hold on;
plot(y_avg_1, fitline, 'k--', 'LineWidth', 1.5);
xlabel('CIMS signal (ions/s)');
ylabel('[H2SO4] modelled (cm^{-3})');
title('SA calibration');
legend('Calibration data', sprintf('Linear fit: m = %.2e', m), 'Location', 'Northwest');
grid on;

%% Calculate SA calibration factor (cm-3) - 2 calibrations

% Compare SA modelled and SA measured
figure
ax1 = axes 
yyaxis left 
scatter(H2Oconc,H2SO4,'Linewidth',1.5,'MarkerEdgeColor','blue')  
xlabel('[H2O] modelled, cm-3'); 
ylabel('[H2SO4] modelled, cm-3'); 
title('y_1')
pause(0.1) 
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'manual'; 
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)]; 
ax1.XLimMode = 'manual'; 
grid(ax1,'on') 
ytick = ax1.YTick; 
yyaxis right 
scatter(H2Oconc,y_avg_1, 'Linewidth',1.5,'MarkerEdgeColor','red') 
ylabel('CIMS signal');  
legend('[H2SO4] modelled, cm-3 (left axis)','CIMS signal (right axis)','Location','Southeast') 

figure
ax1 = axes 
yyaxis left 
scatter(H2Oconc,H2SO4,'Linewidth',1.5,'MarkerEdgeColor','blue')  
xlabel('[H2O] modelled, cm-3'); 
ylabel('[H2SO4] modelled, cm-3'); 
title('y_2')
pause(0.1) 
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'manual'; 
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)]; 
ax1.XLimMode = 'manual'; 
grid(ax1,'on') 
ytick = ax1.YTick; 
yyaxis right 
scatter(H2Oconc,y_avg_2, 'Linewidth',1.5,'MarkerEdgeColor','red') 
ylabel('CIMS signal');  
legend('[H2SO4] modelled, cm-3 (left axis)','CIMS signal (right axis)','Location','Southeast') 

% Calculate mean calibration factor  
C1 = H2SO4 ./ y_avg_1
C2 = H2SO4 ./ y_avg_2
C = vertcat(C1,C2)
mean_C = mean(C)
std_C = std(C)
figure
scatter(H2SO4,C1,'Linewidth',1.5,'MarkerEdgeColor','blue')
hold on, scatter(H2SO4,C2,'Linewidth',1.5,'MarkerEdgeColor','red')
xlabel('[H2SO4] modelled, cm-3'); 
ylabel('Calibration factor, cm-3'); 
ylim([0, max(C)+3e9])
title('SA calibration');
hold on, plot([0, max(H2SO4)+0.5e8], [mean_C,mean_C], 'k--', 'LineWidth', 1.5); 
hold on, errorbar(max(H2SO4)+0.5e8, mean_C, std_C, 'k.', 'LineWidth', 1.5); 
legend('Calibration 1','Calibration 2', 'Mean calibration factor', 'Standard deviation calibration factor','Location','Southwest') 
text(max(H2SO4)+0.5e8, mean_C, sprintf('Mean = %.2e', mean_C), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 18, 'Color', 'black'); 

%% Calculate SA calibration factor as slope of linear fit - 2 calibrations

% Linear fit 1: H2SO4 = m1 * y_avg_1
coeffs1 = polyfit(y_avg_1, H2SO4, 1); 
m1 = coeffs1(1);
fit1 = polyval(coeffs1, y_avg_1);

% Linear fit 2: H2SO4 = m2 * y_avg_2
coeffs2 = polyfit(y_avg_2, H2SO4, 1);
m2 = coeffs2(1);
fit2 = polyval(coeffs2, y_avg_2);

% Average slope
mean_m = mean([m1, m2]);

% Plot
figure;
h1 = scatter(y_avg_1, H2SO4, 'filled', 'MarkerFaceColor', 'blue'); 
hold on;
h2 = plot(y_avg_1, fit1, 'b--', 'LineWidth', 1.5);
h3 = scatter(y_avg_2, H2SO4, 'filled', 'MarkerFaceColor', 'red');
h4 = plot(y_avg_2, fit2, 'r--', 'LineWidth', 1.5);
h5 = plot(nan, nan, 'k:'); % invisible, needed for legend

xlabel('CIMS signal (ions/s)');
ylabel('[H2SO4] modelled (cm^{-3})');
title('SA calibration');

legend([h1, h2, h3, h4, h5], ...
       'Calibration 1', sprintf('Fit 1: m = %.2e', m1), ...
       'Calibration 2', sprintf('Fit 2: m = %.2e', m2), ...
       sprintf('Average slope m = %.2e', mean_m), ...
       'Location', 'Northwest');

grid on;