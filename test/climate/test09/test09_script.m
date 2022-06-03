clear 
%% create exterior climate signal
load('CS3_9_sysclima_no_heater.mat')
ids.Windows = 0.5*ids.EstadoCenitalE + 0.5*ids.EstadoCenitalO;
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
%%
screen = [];
screen.signals.values = [ids.EstadoPant1];
screen.signals.dimensions = 1;
screen.time = tspan;
%% Initializate Parametes of model 
A_span = [0.1 0.5 2.0 ];

clear params;
for i = 1:length(A_span)
    params(i) = climate_p;
%     params(i).tau_c = 0.99;
    params(i).alpha_c = 0.025;
%     params(i).AR = 0.03;
%     params(i).minWindows = 0.5;
%     params(i).alpha_f = 0.1;
%     params(i).minWindows = A_span(i) ;
end
%%
clear in;
for i = 1:length(A_span)
    in(i) = Simulink.SimulationInput('test09');
    in(i) = in(i).setBlockParameter('test09/Climate Model',...
        'minWindows',"A_span(i)");
end
%% Initializate initial conditions of model 
%cic    = climate_ic;

%%
set_param('test09','StopTime',num2str(ndays))

results = sim(in);
%%

for i = 1:length(A_span)
    tout = results(i).tout;
    rdate = t0 + days(tout);
    % Take Indoor Climate Signals
    IC = results(i).logsout.getElement('Indoor Climate');
    IC_st = parseIndoorClimate(IC,tout);
    % Take Outdoor Climate Signals
    OC = results(i).logsout.getElement('Outdoor Climate');
    OC_st = parseIndoorClimate(OC,tout);
    % see results
    figure(i)
    clf
    ICplots_test09_sysclima(rdate,IC_st,OC_st,ids,A_span(i))
end

%%