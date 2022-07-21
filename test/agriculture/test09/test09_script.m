clear
%load('src/data/CS3_1_Sysclima.mat')
load('CS3_7_all_cum_production.mat')

%%
ds_crop = new_ds_prod_2{3};
%figure(1)
%clf
%plot(ds_crop.DateTime,ds_crop.MatureFruit,'.-')

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
hour0 = (t0.Hour + t0.Minute/60)/24;
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
crop_params.VelocityAbsortion = 10;
%crop_params.C = 1e-8*[1 1 1 1];
%crop_params.tinit = 3;
%crop_params.tend = 6;

%x0_crop = crop_ic;
%% Initializate Fruit
params_fruit = fruit_p;
%x0_fruit =  fruit_ic;
%% Initializate Substrate
substrate_params = substrate_p;
substrate_params.Nmin_subs = 1e-3;
substrate_params.DraingeConst = 1e-5;
%x0_substrate = substrate_ic;
%% We use a non virtual buses in flow 
BuildBusFlow;
%% Execute model

open_system('test09')
%set_param('test09','StopTime','tspan(end)')
set_param('test09','StopTime','10')
%set_param('test09','StopTime','1')

set_param('test09','SimulationMode','normal')

tic

r = sim('test09');
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
%figure(1)
%clf
%ICplots_test01(rdate,IC_st,OC_st)
%%
fig = figure(1);
fig.Units = 'norm';
fig.Position = [0 0 0.5 0.7];
clf
ICplots_test08_b(rdate,IC_st,OC_st,CC_st,Crop_st,Fruit,ds_crop,crop_p)

%%
%fig = figure(1);
%ICplots_test03(rdate,IC_st,OC_st,CC_st,win_p,win_com_st)

%%
% figure(1)
% clf
% subplot(3,1,1)
% hold on
% plot(rdate,Substrate_st.SusWater.VT)
% plot(rdate,Crop_st.Water.WaterState.VegWater)
% 
% subplot(3,1,2)
% hold on
% plot(rdate,Substrate_st.Drainge.f)
% plot(rdate,Substrate_st.Uptake.Water)
% plot(rdate,Irrigation_st.f)
% plot(rdate,Crop_st.Water.WaterFlows.WaterDemand)
% legend('Drainge','Update','Irrigation')
% 
% subplot(3,1,3)
% hold on
% plot(rdate,Substrate_st.Uptake.Water)
% plot(rdate,Crop_st.Water.WaterFlows.WaterUptake,'--')
% legend('sub_uptake','crop_uptake')

%%
figure(2)
clf
subplot(8,1,1)
hold on
plot(rdate,Substrate_st.Mass)
yline(substrate_params.Nmin_subs)
legend('Mass Subtrate')

subplot(8,1,2)
hold on
plot(rdate,Substrate_st.Uptake.Nutrients)
legend('Uptake CROP')
%ylim([0 5e-9])

subplot(8,1,3)
hold on
plot(rdate,-Substrate_st.Drainge.X.*Substrate_st.Mass)
legend('Drain')
%

FI = Irrigation_st.X.*Irrigation_st.f;

subplot(8,1,4)
hold on
plot(rdate,FI)
legend('Ferti')


%
subplot(8,1,5)
plot(rdate,(Substrate_st.Drainge.f))
legend('Drain Water')
%

subplot(8,1,6)
plot(rdate,Substrate_st.Drainge.X)
legend('Concentration Water')
%
subplot(8,1,7)

plot(rdate,Crop_st.Nutrients.Mass)
legend('Mass Crop')


subplot(8,1,8)

plot(rdate,Crop_st.Nutrients.Demand)
legend('Nutrient Demand')

%%
figure(1)
clf
plot(rdate,Crop_st.Tsum)
