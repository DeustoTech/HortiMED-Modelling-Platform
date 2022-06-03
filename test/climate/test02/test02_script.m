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
%% Initializate initial conditions of model 
%cic    = climate_ic;
%% Execute model
minWin_span = [0.00 0.1 0.2 0.9];
set_param('test02','StopTime','2')
minWin_span = [5 10 50 100];

iter = 0;
fig = figure(1);
clf
set_param('test02/Climate Model','minWindows','0.1')
for iminWin = minWin_span 
    iter = iter + 1;
    %set_param('test02/Climate Model','minWindows',num2str(iminWin))
    set_param('test02/Climate Model','H',num2str(iminWin))

    %params.minWindows = iminWin;
    tic
    r = sim('test02');
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
    %% see results
    ui = uipanel('unit','norm','pos',[(iter-1)/4 0 1/4 1],'Parent',fig);
    axes('Parent',ui)
    ti = "min Win = "+iminWin;
    ICplots_test02(rdate,IC_st,OC_st,ti)
end
