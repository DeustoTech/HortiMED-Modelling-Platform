clear 
%% create exterior climate signal
load('CS3_9_sysclima_with_heater.mat')
load('opt_params_climate_menaka.mat')
ids = ids_heater;
ids = ids(1000:3000,:);
open_system('test13')
ids.Windows = 0.5*ids.EstadoCenitalE + 0.5*ids.EstadoCenitalO;
%%

%%
%ids.Vviento = smoothdata(ids.Vviento,'gaussian','SmoothingFactor',0.15);
old_viento = ids.Vviento;
ids.Vviento = smoothdata(ids.Vviento,'gaussian','SmoothingFactor',0.15);

%%
ids.Text = ids.Text + 273.15;
ids.Tinv = ids.Tinv + 273.15;
%%
ndays = 8;
%%
%
t0 = ids.DateTime(1);
tspan = days(ids.DateTime - t0);
%
climate = [];
climate.signals.values = [ids.Text+273.15 ids.RadExt ids.HRExt ids.Vviento];
climate.signals.dimensions = 4;
climate.time = tspan;

%%
windows = [];
windows.signals.values = ids.Windows;
windows.signals.dimensions = 1;
windows.time = tspan;

%% Initializate Parametes of model 
params = climate_p;
%%
heat_p = heater_p;
heat_ic = heater_ic;

heat_p.power = 250*1e3*4;
heat_p.A_i = 1e-5;

%%
T_max_heater = 273.15 + 20;
T_start_heater = 273.15 + 10;

%%
%%
%% Take Temperature 
%Tinv.values = ids.Tinv;
%Tinv.tspan = tspan;

%%
in = Simulink.SimulationInput('test13');
%%
set_param('test13','SimulationMode','accelerator')
set_param('test13','StopTime',num2str(ndays))

%% Initializate initial conditions of model 
cic    = climate_ic;
%%

%%
main_folder = which('HORTISIM.slx');
main_folder = replace(main_folder,'HORTISIM.slx','');
%
%%
save(fullfile(main_folder,'test/test11/opt_params_climate_menaka.mat'),'climate_params','windows_params')
