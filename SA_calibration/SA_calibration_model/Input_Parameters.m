%% input parameters
% set these inputs and run the file
clear all;

T = 297.15; % K % adapted
p = 101325; % Pa % adapted

ID = 15.30; % mm, inner diameter tube % adapted
L = 550.00; % mm % adapted
Q = 11.50; % lpm, not slpm % adapted

It = 4.16e11; % at Q flow rate % adapted
%Qx = 9.5; % lpm % not used

N2Flow = 12.0; % slpm % adapted
AirFlow = 70; % smlpm % adapted
WaterFlow = [125 250 500 750 1000]'; % smlpm % adapted
SO2Flow = 3; % smlpm % adapted

SO2BottlePpm = 5000; % ppm % adapted

O2inAir = 0.209;

outflowLocation = 'after'; % outflow tube located before or after injecting air, water, and so2

fullOrSimpleModel = 'full'; % simple: Gormley&Kennedy approximation, full: flow model (much slower)

%% computation begins

if strcmp(outflowLocation,'after')
    totFlow = N2Flow+AirFlow/1000+WaterFlow/1000+SO2Flow/1000;
else
    totFlow = Q*ones(size(WaterFlow));
end
O2conc = O2inAir*AirFlow/1000./totFlow*p/1.3806488e-23/T/1e6;
H2Oconc = WaterFlow/1000./totFlow*vappresw(T)/1.3806488e-23/T/1e6;
SO2conc = SO2Flow/1000./totFlow*SO2BottlePpm*1e-6*p/1.3806488e-23/T/1e6;

%It = Itx*Qx/Q;

H2SO4 = zeros(size(WaterFlow));
for i=1:numel(H2SO4)
    H2SO4(i)=cmd_calib1Matlab(O2conc(i),H2Oconc(i),SO2conc(i),ID/10/2,L/10,Q*1000/60,It,T,p,fullOrSimpleModel);
end