
clear
%load('src/data/CS3_1_Sysclima.mat')
load('CS3_7_all_cum_production.mat')

%%
ds_crop = new_ds_prod_2{3};
figure(1)
clf
plot(ds_crop.DateTime,ds_crop.MatureFruit,'.-')

%%
load('CS3_2_ExteriorClima.mat')

t0 = datetime("15-Feb-"+ds_crop.DateTime(1).Year);
tend = ds_crop.DateTime(end);
ind_b = logical((ds.DateTime > t0).*(ds.DateTime < tend));
ods = ds(ind_b,:);

%% create exterior climate signal

%
%
t0 = ods.DateTime(1);
tspan = days(ods.DateTime - t0);
%
climate = [];
climate.signals.values = [ods.temp ods.RadCloud ods.humidity ods.wind_speed];
climate.signals.dimensions = 4;
climate.time = tspan;

%% Initializate Parametes of model 
params = climate_p;
params.minWindows = 0.3;
params.tau_c = 0.99;
params.alpha_c = 1e-4;
params.alpha_i = 1e-4;

%% Initializate initial conditions of model 
%cic    = climate_ic;
%% Initializate of Windows System
win_p = windows_p;
%% Screen parameters
scr_p = screen_p;
scr_p.Radthreshold = 1000;
%% Initializate Heater
heat_p = heater_p;
heat_p.power = 1000e3;
%heat_ic = heater_ic;
%% Initializate Crop
crop_params = crop_p;
%x0_crop = crop_ic;
%% Initializate Fruit
params_fruit = fruit_p;
%x0_fruit =  fruit_ic;
%% Initializate Substrate
substrate_params = substrate_p;
%x0_substrate = substrate_ic;
%% We use a non virtual buses in flow 
BuildBusFlow;
%% Execute model

open_system('test08')
%set_param('test08','StopTime','tspan(end)')
set_param('test08','StopTime','10')

set_param('test08','SimulationMode','normal')

tic

r = sim('test08');
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
%% Screen consumption
src_com = r.logsout.getElement('ScreenC');
src_com_st = src_com.Values.Data;
%%
%% Windows consumption
win_com = r.logsout.getElement('WindowsC');
win_com_st = win_com.Values.Data;
%%
heater_signal =  r.logsout.getElement('Heater').Values.Data;
Th =  r.logsout.getElement('Th').Values.Data;
heater_con =  r.logsout.getElement('HeaterCon').Values.Data;
%% Crop 
Crop = r.logsout.getElement('Crop');
Crop_st = parseIndoorClimate(Crop,tout);
%%
Fruit = r.logsout.getElement('Tomato');
Fruit = Fruit.Values.Data;
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
%fig.Units = 'norm';
%fig.Position = [0 0 0.5 0.7];
clf
ICplots_test08_b(rdate,IC_st,OC_st,CC_st,Crop_st,Fruit,ds_crop,crop_p)

%%
fig = figure(1);
ICplots_test03(rdate,IC_st,OC_st,CC_st,win_p,win_com_st)


%%
%%
%%
%%
IC = r.logsout.getElement('Indoor Climate');
IC_st = parseIndoorClimate_csv(IC,tout);
IC_st = struct2table(IC_st);

INDOOR_NAMES = IC_st.Properties.VariableNames;
%%
Control_IC =  r.logsout.getElement('Control Climate');
Control_IC_st_st = parseIndoorClimate(Control_IC,tout);
Control_IC_st = parseIndoorClimate_csv(Control_IC,tout);
Control_IC_st = struct2table(Control_IC_st);
CONTROL_NAMES = Control_IC_st.Properties.VariableNames;

%%
Crop1 = r.logsout.getElement('Crop');
Crop1_st = parseCrop_csv(Crop1,tout);
Crop1_st_st = parseCrop(Crop1,tout);

Crop1_st = struct2table(Crop1_st);
CROP_NAMES = Crop1_st.Properties.VariableNames;

%%
Fruit_st= [];
Fruit = r.logsout.getElement('Tomato');
Fruit_st.FruitRip = Fruit.Values.Data;
Fruit_st = struct2table(Fruit_st);

%%
Subs_1 = r.logsout.getElement('Subs');
Subs_1_st = parseSubstrate_csv(Subs_1,tout);
Subs_1_st = struct2table(Subs_1_st);
SUBS_NAMES = Subs_1_st.Properties.VariableNames;


save('data/RSIM_VARS_NAMES.mat','INDOOR_NAMES','CONTROL_NAMES','CROP_NAMES','SUBS_NAMES')
%
%%

dataset = [IC_st Control_IC_st Crop1_st Fruit_st Subs_1_st ];
dataset.DateTime = rdate;

%%

new_tspan = rdate(1):minutes(10):rdate(end);

new_dataset = [];
for ivar = dataset.Properties.VariableNames
   new_dataset.(ivar{:}) = interp1(days(rdate-t0),dataset.(ivar{:}),days(new_tspan-t0))';
end

%%
new_dataset = struct2table(new_dataset);


%%
writetable(new_dataset,'dataset.csv')

%%

