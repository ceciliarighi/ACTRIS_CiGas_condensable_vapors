%% This script is used to calculate the It product based on N2O experiments for CI-APi-TOF
% created by Xu-Cheng (Lance) He - May 17th, 2019

% --N2_flow: main nitrogen flow in sccm
% --N2O_flow: N2O flow in sccm
% --NOx: NOx concentration in ppb
% --Temp: temperature in celsius
% --NOx_bg: background NOx level in ppb
% --pres: pressure in pascal
% --R: inner radius of quartz tube (should be the same as CI-inlet) 3/4" = 0.78cm
% --NOx_moni_detec_limit: detection limit of the NOx monitor. If the value is
% set to 0 then the measured values are well above the detection limit of
% the instrument
% --flow_inlet_CI_inlet: flow rate of the CI inlet which is used for the SA
% calibration
% final product is It_corr_CI_inlet
%%
clear all
close all

%% parameter input
Temp=25; %celsius, temperature

N2_flow=[6696;6466;6250;6048;5859;5682;5515;5357;5208;5068]; %sccm, volumetric flow

N2O_flow=[804;1034;1250;1452;1641;1818;1985;2143;2292;2432]; %sccm, volumetric flow

NOx=[4.32;5.650;6.749;7.642;8.609;9.410;10.060;10.657;11.241;11.581]; %ppb

NOx_bg=0; %ppb

pres=96000; %Pa

R=0.78; %cm

NOx_moni_detec_limit=0; %ppb 

flow_inlet_CI_inlet=7500; %sccm, inlet flow CI-API-TOF

%% NO background remover
NOx=NOx-NOx_bg;

%% delete the NOx values smaller than the detection limit
above_dete=find(NOx>NOx_moni_detec_limit);

N2_flow=N2_flow(above_dete);
N2O_flow=N2O_flow(above_dete);
NOx=NOx(above_dete); %ppb

%% calculation
% parameters
T=Temp+273.15; %K
K6=2.0*10^-11*exp(130/T); %cm3 mol-1 s-1
K7=7.6*10^-11; %cm3 mol-1 s-1
K8=4.3*10^-11; %cm3 mol-1 s-1
K9=6.0*10^-12; %cm3 mol-1 s-1

phi_N2O=1; %quantum yield
sigma_N2O=1.43*10^-19; %absorption cross section cm2

mixing_N2=N2_flow./(N2O_flow+N2_flow);
mixing_N2O=N2O_flow./(N2O_flow+N2_flow);

%% calculation of It product
It_N2O=(K6*mixing_N2+(K7+K8+K9)*mixing_N2O).*NOx*10^-9./(2*K7*sigma_N2O*phi_N2O*mixing_N2O.^2);

%calibrate with the inlet flow
It_CI_inlet=It_N2O.*(N2_flow+N2O_flow)/flow_inlet_CI_inlet;

%% geometry correction
N2O_conc=pres./1.38e-23./T./1e6*mixing_N2O; % molecules cm-3

for k = 1:length(mixing_N2O)
funcart = @(x,y) exp(-sigma_N2O*N2O_conc(k)*(sqrt(R^2-y.^2)+x));
ymin = @(x) -sqrt(R^2-x.^2);
ymax = @(x) sqrt(R^2-x.^2);

q(k) = integral2(funcart,-R,R,ymin,ymax);
end
q=q';
K = q/R^2/pi;

%% It final 
It_corr_CI_inlet=It_CI_inlet./K;
It_corr_CI_inlet_median=median(It_corr_CI_inlet);
It_corr_CI_inlet_low=min(It_corr_CI_inlet);
It_corr_CI_inlet_high=max(It_corr_CI_inlet);

%% calculate the finalized It
figure(1)
plot(1:length(It_corr_CI_inlet),It_corr_CI_inlet,'linewidth',2.5)
set(gca,'fontsize',25,'linewidth',1.5)
xlabel('data point number')
ylabel('It product')
box off
