%% SA normalized signal
% Cecilia Righi  

figure; 
plot(time, sa_conc, 'LineWidth', 1.5, 'Color', 'blue') % time and sa_conc extracted from Tofware or tofTools 
xticks([])
xticklabels([])
xlabel('Time')
ylabel('H2SO4 normalized signal')
title('APi12 calibration - 2025.04.09')

average_from_fig; 