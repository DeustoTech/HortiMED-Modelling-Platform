clear 
%% create exterior climate signal
load('CS3_9_sysclima_no_heater.mat')

%%
ndays = 10;

%%
%
t0 = ids.DateTime(1);
tspan = days(ids.DateTime - t0);
%
climate = [];
climate.signals.values = [ids.Text+273.15 ids.RadExt ids.Text*0+80 ids.Vviento];
climate.signals.dimensions = 4;
climate.time = tspan;

%%
windows = [];
windows.signals.values = [ids.EstadoCenitalE*0.5 + ids.EstadoCenitalO*0.5];
windows.signals.dimensions = 1;
windows.time = tspan;
%%
screen = [];
screen.signals.values = [ids.EstadoPant1];
screen.signals.dimensions = 1;
screen.time = tspan;
%% Initializate Parametes of model 
A_f_span = [100 500];
clear params;
for i = 1:length(A_f_span)
    params(i) = climate_p;
    params(i).A_f = A_f_span(i);
end
%%
clear in;
for i = 1:length(A_f_span)
    in(i) = Simulink.SimulationInput('test09');
    in(i) = in(i).setBlockParameter('test09/Climate Model',...
        'params',"params("+i+")");
end
%% Initializate initial conditions of model 
cic    = climate_ic;

%%
simOut = sim('test09');

results = sim(in);
%%

for i = 1:length(A_f_span)
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
    ICplots_test01_sysclima(rdate,IC_st,OC_st,ids)
end

%%