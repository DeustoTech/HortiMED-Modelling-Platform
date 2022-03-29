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
%%
heat_p = heater_p;
heat_p.power = 1000e3;
heat_ic = heater_ic;
%% Execute model

open_system('test05')
set_param('test05','StopTime','5')

tic

r = sim('test05');
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

%% see results
figure(1)
clf
ICplots_test05(rdate,IC_st,OC_st,heater_signal,Th,heater_con)
