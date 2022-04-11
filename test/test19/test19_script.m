clear 
%% create exterior climate signal
load('CS3_12_sysclima_no_heater_with_screen.mat')
open_system('test19')
ids.Windows = 0.5*ids.EstadoCenitalE + 0.5*ids.EstadoCenitalO;
%%
AR = 50;
    
%%
%ids.Vviento = smoothdata(ids.Vviento,'gaussian','SmoothingFactor',0.15);
old_viento = ids.Vviento;
ids.Vviento = smoothdata(ids.Vviento,'gaussian','SmoothingFactor',0.15);
%%
ids.RadExt = smoothdata(ids.RadExt,'gaussian','SmoothingFactor',0.05);
ids.RadInt = smoothdata(ids.RadInt,'gaussian','SmoothingFactor',0.05);

ids.Tinv = smoothdata(ids.Tinv,'gaussian','SmoothingFactor',0.01);
ids.Text = smoothdata(ids.Text,'gaussian','SmoothingFactor',0.01);

%%
ids.Text = ids.Text + 273.15;
ids.Tinv = ids.Tinv + 273.15;
%%
ndays = 5;
%%
%
t0 = ids.DateTime(1);
tspan = days(ids.DateTime - t0);
%
climate = [];
climate.signals.values = [ids.Text ids.RadExt ids.HRExt ids.Vviento];
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
%%
%set_param('test19','SimulationMode','accelerator')
set_param('test19','StopTime',num2str(ndays))

%% Initializate initial conditions of model 
cic    = climate_ic;
cic.T0 = zeros(4,1) + ids.Tinv(1);
%%
%% Obtain these parameters
load('test18_ws','climate_params')
load('test18_ws','AR')
%%
gamma = 0.1;
beta  = 10;
beta = 50;
%%
r = sim('test19');

%%
IC = r.logsout.getElement('Indoor Climate');
IC_st = parseIndoorClimate(IC,r.tout);
%%
CC =  r.logsout.getElement('Control Climate');
CC_st = parseIndoorClimate(CC,r.tout);
%%
CE =  r.logsout.getElement('External Climate');
CE_st = parseIndoorClimate(CE,r.tout);
%%
main_folder = which('HORTISIM.slx');
main_folder = replace(main_folder,'HORTISIM.slx','');
%
save(fullfile(main_folder,'test/test18/test18_ws.mat'))


%%
rdate = t0 + days(r.tout);
tend = rdate(end);
%
indx = find(ids.DateTime < tend);
indx = indx(1):15:indx(end);
%%
figure(1)
Tk = 273.15;
clf
subplot(4,1,1)
hold on
plot(rdate,IC_st.Temp.Tair - Tk,'Color','r','LineWidth',2)
plot(ids.DateTime(indx),ids.Tinv(indx) - Tk,'o','Color','r')
%plot(rdate,CE_st.Temp,'Color','b','LineWidth',2)
yyaxis right
plot(rdate,CC_st.Screen.value,'Color','k','LineWidth',2)
title("Temperature | \beta = "+num2str(beta))
%legend('T_i^{sim}','T_i^{real}','T_e','R_e')
%legend('T_i^{sim}','T_i^{real}','T_e')
legend('T_i^{sim}','T_i^{real}','Screen')
grid on
xlim([rdate(1) rdate(end)])
subplot(4,1,2)
plot(rdate,CC_st.Windows.value,'-','LineWidth',2)
xlim([rdate(1) rdate(end)])
grid on
title('Windows')


subplot(4,1,3)
hold on
plot(rdate,CE_st.Rad,'Color','b','LineWidth',2)
plot(rdate,IC_st.QS.R_int,'Color','r','LineStyle','-','LineWidth',2)
plot(ids.DateTime(indx),ids.RadInt(indx),'o','Color','r')
xlim([rdate(1) rdate(end)])
grid on
title('Radiation')

%
subplot(4,1,4)
hold on
%plot(rdate,CE_st.HR,'Color','b','LineWidth',2)
plot(rdate,IC_st.Gas.HRInt,'Color','r','LineWidth',2)
%
plot(ids.DateTime(indx),ids.HRInt(indx),'o','Color','r')
xlim([rdate(1) rdate(end)])
legend('H_i^{sim}','H_i^{real}')
title('Humidity')

grid on

%%
figure(2)
clf
ICplots_test01(rdate,IC_st,CE_st)
%%


