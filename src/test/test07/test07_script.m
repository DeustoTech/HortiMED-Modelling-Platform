clear
%% create exterior climate signal
load('CS3_5_ExteriorClima.mat')
ods = ods(3200:end,:);
%
ods.T = ods.T;
%
t0 = ods.DateTime(1);
tspan = days(ods.DateTime - t0);
%
climate = [];
climate.signals.values = ods{:,1:4};
climate.signals.dimensions = 4;
climate.time = tspan;

%% Initializate Parametes of model 
params = climate_p;
params.minWindows = 0.01;
%% Initializate initial conditions of model 
cic    = climate_ic;
%% Initializate of Windows System
win_p = windows_p;
%% Screen parameters
scr_p = screen_p;
scr_p.Radthreshold = 200;
%% Initializate Heater
heat_p = heater_p;
heat_p.power = 1000e3;
heat_ic = heater_ic;
%% Initializate Crop
crop_params = crop_p;
x0_crop = crop_ic;
%% Initializate Substrate
substrate_params = substrate_p;
x0_substrate = substrate_ic;
%% We use a non virtual buses in flow 
BuildBusFlow;
%% Execute model

open_system('test07')
set_param('test07','StopTime','20')

tic

r = sim('test07');
toc
%% build the date span from tspan pf simulation 
tout = r.tout;
rdate = t0 + days(tout);
%% Take Indoor Climate Signals
IC = r.logsout.getElement('Indoor Climate');
IC_st = parseIndoorClimate(IC,tout);
%% Take Outdoor Climate Signals
OC = r.logsout.getElement('Outdoor Climate');
OC_st = parseIndoorClimate(OC,tout);
%%
CC = r.logsout.getElement('Control Climate');
CC_st = parseIndoorClimate(CC,tout);
%% Windows parameters
src_com = r.logsout.getElement('ScreenC');
src_com_st = src_com.Values.Data;
%%
heater_signal =  r.logsout.getElement('Heater').Values.Data;
Th =  r.logsout.getElement('Th').Values.Data;
heater_con =  r.logsout.getElement('HeaterCon').Values.Data;
%% Crop 
Crop = r.logsout.getElement('Crop');
Crop_st = parseIndoorClimate(Crop,tout);
%% Substrate
Substrate =  r.logsout.getElement('Subs');
Substrate_st = parseSubstrate(Substrate,tout);
%% Irrigation
Irrigation = r.logsout.getElement('Ferti');
Irrigation_st = parseFertirrigation(Irrigation,tout);
%% see results
figure(1)
clf
ICplots_test01(rdate,IC_st,OC_st)
%%
fig = figure(1);
fig.Units = 'norm';
fig.Position = [0 0 0.5 0.7];
clf
ICplots_test06(rdate,IC_st,OC_st,Crop_st)
