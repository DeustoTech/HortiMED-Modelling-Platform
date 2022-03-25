clear 
%% create exterior climate signal
load('CS3_9_sysclima_no_heater.mat')
open_system('test10')
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
params = climate_p;

%%
%% Take Temperature 
Tinv.values = ids.Tinv;
Tinv.tspan = tspan;

%%
in = Simulink.SimulationInput('test10');
%%
set_param('test10','SimulationMode','accelerator')
set_param('test10','StopTime',num2str(ndays))

%% Initializate initial conditions of model 
cic    = climate_ic;
%%
hws = get_param('test10', 'modelworkspace');

%%

%%
opts= optimoptions('fmincon');
opts.Display = 'iter';
%%
xopt = fmincon(@(x) cost_fcn(hws,in,params,Tinv,x,false),5, ...
                                                [],[], ...
                                                [],[], ...
                                                1,100,...
                                                [],opts);

%%
cost_fcn(hws,in,params,Tinv,xopt,true)
%%

function r = cost_fcn(hws,in,param0,Tinv,p0,plot_b)

    param0.AR = p0;

    hws.assignin('params',param0);

    rs = sim(in);
    
    IC = rs.logsout.getElement('Indoor Climate');
    Tsim = IC.Values.Temp.Tair.Data - 273.15;

    Tinv_interp = interp1(Tinv.tspan,Tinv.values,rs.tout);
    
    r = mean((Tsim - Tinv_interp).^2);
    %%
    if plot_b
        clf
        hold on
        plot(rs.tout,Tsim)
        plot(rs.tout,Tinv_interp)

    end
end
