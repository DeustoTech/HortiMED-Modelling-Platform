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
A_f_span = [100 500 2000 3000];
clear params;
for i = 1:length(A_f_span)
    params(i) = climate_p;
    params(i).A_f = A_f_span(i);
end
%%
clear in;
for i = 1:length(A_f_span)
    in(i) = Simulink.SimulationInput('test01');
    in(i) = in(i).setBlockParameter('test01/Climate Model',...
        'params',"params("+i+")");
end
%% Initializate initial conditions of model 
cic    = climate_ic;

%%
simOut = sim('test01','SimulationMode','rapid');

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
    ICplots_test01(rdate,IC_st,OC_st)
end

%%