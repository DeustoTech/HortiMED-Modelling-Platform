clear
%% create exterior climate signal
load('CS3_5_ExteriorClima.mat')
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
%params = climate_p;
%params.minWindows = 0.01;
%% Initializate initial conditions of model 
%cic    = climate_ic;
%% Initializate of Windows System
%win_p = windows_p;
%% Screen parameters
%scr_p = screen_p;
%scr_p.Radthreshold = 200;
%% Execute model

open_system('test04')
set_param('test04','StopTime','10')

tic

r = sim('test04');
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

%% see results
figure(1)
clf
win_p = windows_p;
scr_p = screen_p;
ICplots_test04(rdate,IC_st,OC_st,CC_st,win_p,scr_p,src_com_st)
