%% N2O actinometry experiment | It-factor computation
% created by Lisa Beck 
% modified by Cecilia Righi - latest update: May 2025

%% User interface
N2O_flow=[804 1034 1250 1452 1641 1818 1985 2143 2292 2432]; % sccm, ADJUST
N2_flow=[6696 6466 6250 6048 5859 5682 5515 5357 5208 5068]; % sccm, ADJUST
NOx_ppb=[5.300 6.413 7.800 8.983 9.893 10.919 11.781 12.319 13.044 13.566] ; % ppb, ADJUST

T=25; % °C, ADJUST

QtotNOx=7.5; % lpm, ADJUST
Qinstrument=10; % lpm, ADJUST

R=0.78; % cm, inner radius, ADJUST

%% It-Product - not corrected
T=T+273.15; % K
p=96000; %Pa
kB=1.3806488e-23; % J K-1

k6=2e-11*exp(130/T); % cm3 mol-1 s-1
k7=7.6e-11; % cm3 mol-1 s-1
k8=4.3e-11; % cm3 mol-1 s-1
k9=6.0e-12; % cm3 mol-1 s-1

qyN2O=1;
csN2O=1.43e-19; % cm2

M=p/(kB*T)/1e6; % cm-3
N2O_ratio=N2O_flow./(N2O_flow+N2_flow);
N2_ratio=N2_flow./(N2O_flow+N2_flow);
N2O=N2O_ratio.*M; % cm-3
N2=N2_ratio.*M; % cm-3
NOx=NOx_ppb*1e-9*M; % cm-3

ItNOx=(k6*N2+(k7+k8+k9).*N2O)./(2*k7*csN2O*qyN2O.*N2O.^2).*NOx;
It=ItNOx(:)*(QtotNOx./Qinstrument);

It_mean=mean(It);
It_median=median(It);
It_std=std(It);

%% It-Product - corrected
K = zeros(length(N2O), 1);

for i = 1:length(N2O)
    a = N2O(i);
    f = @(r,phi) exp(-csN2O .* a .* (sqrt(R.^2 - (r .* sin(phi)).^2) + r .* cos(phi))) .* r;
    K(i) = 2 * integral2(f, 0, R, 0, pi) / (pi * R^2);
end

ItCorrected=It./K;

It_corrected_mean=mean(ItCorrected);
It_corrected_median=median(ItCorrected);
It_corrected_std=std(ItCorrected);

%% Plot
figure
hold on
yyaxis left
plot(N2O_ratio, NOx_ppb,'bx')
ylim([0, max(NOx_ppb)+1])
ylabel('NOx concentration (ppb)')
yyaxis right
plot(N2O_ratio,ItCorrected,'ro')
ylim([0, max(ItCorrected)+1e11])
ylabel('It-factor')
xlabel('N_2O/N_2 ratio')
title('Actinometry experiment')