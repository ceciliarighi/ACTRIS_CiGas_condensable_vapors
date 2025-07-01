%% N2O actinometry experiment | It-factor computation
% created by Lisa Beck 
% modified by Cecilia Righi - latest update: July 2025

% --N2O_flow: set N2O flow rate (sccm)
% --N2_flow: set N2 flow rate (sccm)
% --NOx_ppb: NOₓ concentration detected by the NOₓ monitor (ppb)
% --T: average of N2O flow and N2 flow temperatures (°C)
% --QtotNOx: inlet flow rate used in the actinometry experiment (lpm)
% --Qinstrument: inlet flow rate used in the sulfuric acid calibration experiment (lpm)
% --R: inner radius of quartz tube (cm)
% --monitor_bg: background NOₓ concentration (ppb) detected by the NOₓ monitor when 
% N2O flow = 0 and Hg-lamp is on
% --bottle_bg: NOₓ concentration (ppb) detected by the NOₓ monitor repeating the 
% experiment with Hg-lamp off
%% user interface
N2O_flow=[804 1034 1250 1452 1641 1818 1985 2143 2292 2432]; % sccm, ADJUST
N2_flow=[6696 6466 6250 6048 5859 5682 5515 5357 5208 5068]; % sccm, ADJUST
NOx_ppb=[4.325 5.650 6.749 7.642 8.609 9.410 10.060 10.657 11.241 11.581] ; % ppb, ADJUST

T=25; % °C, ADJUST

QtotNOx=7.5; % lpm, ADJUST
Qinstrument=7.5; % lpm, ADJUST

R=0.78; % cm, ADJUST

monitor_bg=0.8; % ppb, ADJUST
bottle_bg=[0.4 0.2 0.2 0.1 0.08 0.06 0.06 0.04 0.04 0.02];  % ppb, ADJUST

%% It-Product - not corrected
T=T+273.15; % K
p=96000; % Pa
kB=1.3806488e-23; % J K-1, Boltzmann constant

k6=2e-11*exp(130/T); % cm3 mol-1 s-1
k7=7.6e-11; % cm3 mol-1 s-1
k8=4.3e-11; % cm3 mol-1 s-1
k9=6.0e-12; % cm3 mol-1 s-1

qyN2O=1; % quantum yield
csN2O=1.43e-19; % cm2, absorption cross section

M=p/(kB*T)/1e6; % cm-3
N2O_ratio=N2O_flow./(N2O_flow+N2_flow);
N2_ratio=N2_flow./(N2O_flow+N2_flow);
N2O=N2O_ratio.*M; % cm-3
N2=N2_ratio.*M; % cm-3
NOx_corrected_ppb=NOx_ppb-monitor_bg-bottle_bg; % ppb
NOx=NOx_corrected_ppb*1e-9*M; % cm-3

ItNOx=(k6*N2+(k7+k8+k9).*N2O)./(2*k7*csN2O*qyN2O.*N2O.^2).*NOx; % photons cm-2
It=ItNOx(:)*(QtotNOx./Qinstrument); % photons cm-2

It_mean=mean(It); % photons cm-2
It_median=median(It); % photons cm-2
It_std=std(It); % photons cm-2

%% It-Product - corrected
K = zeros(length(N2O), 1);

for i = 1:length(N2O)
    a = N2O(i);
    f = @(r,phi) exp(-csN2O .* a .* (sqrt(R.^2 - (r .* sin(phi)).^2) + r .* cos(phi))) .* r;
    K(i) = 2 * integral2(f, 0, R, 0, pi) / (pi * R^2);
end

ItCorrected=It./K;

It_corrected_mean=mean(ItCorrected); % photons cm-2
It_corrected_median=median(ItCorrected); % photons cm-2

%% plot
figure
hold on
yyaxis left
plot(N2O_ratio, NOx_ppb,'bx')
ylim([0, max(NOx_ppb)+1])
ylabel('NOx concentration (ppb)')
yyaxis right
plot(N2O_ratio,ItCorrected,'ro')
ylim([0, max(ItCorrected)+1e11])
ylabel('It-factor (% photons cm-2)')
xlabel('N_2O/N_2 ratio')
title('Actinometry experiment')