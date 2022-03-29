clear 
load('CS1_2_renile')
data = data(1:end-80,:);
%% External Climate
DateTime = data.DateTime;
tspan = days(DateTime - DateTime(1));
Te = 273.15 + data.ambient_temp_Biological_filter_P_5;
Re = data.Rad;
He = data.ambinet_Humi_Biological_filter_P_5;
Ve = data.Rad*0 + 0.5;
%% Indoor CLimate
Ti_GH1 = 273.15 + data.ambient_temp_NFT_P_9;
Ti_GH2 = 273.15 + data.ambient_temp_RT_P_6;
Ti_GH3 = 273.15 + data.ambient_temp_Fish_Pond_P_1;
%%
HR_GH1 = data.ambinet_Humi_NFT_P_9;
HR_GH2 = data.ambinet_Humi_RT_P_6;
HR_GH3 = data.ambinet_Humi_Fish_Pond_P_1;

%%
Tw_tilapia = 273.15 + data.Temp_Bot_Fish_Pond_P_1;
Tw_mullet  = 273.15 + data.Temp_Bot_Fish_Pond_P_2;
Tw_clams   = 273.15 + data.Temp_Bot_Fish_Pond_P_3;
Tw_sedim   = 273.15 + data.Temp_Bot_Fish_Pond_P_4;

%%
climate = [];
climate.signals.values = [Ti_GH3 HR_GH3];
climate.signals.dimensions = 2;
climate.time = tspan;
%%
tp_tilapia = tank_p;
tp_tilapia.S = 50;
tp_tilapia.h_max = 0.8;
tp_tilapia.Twall = 273.15 + 13;
tp_tilapia.wall_gain = 2;

x0_tank_tilapia = tank_ic;
x0_tank_tilapia.T = 273.15 + 17;
%%
%
x0_tank_mullet = tank_ic;
x0_tank_mullet.T = 273.15 + 17;
tp_mullet = tp_tilapia;
tp_mullet.Twall = 273.15 + 15;
%%
%
x0_tank_clams = tank_ic;
x0_tank_clams.T = 273.15 + 16;
%
tp_clams = tp_tilapia;
tp_clams.Twall = 273.15 + 12;
%%
x0_tank_sedim = tank_ic;
x0_tank_sedim.T = 273.15 + 15;
%
tp_sedim = tp_tilapia;
tp_sedim.Twall = 273.15 + 10;
%%
%x0_tank_clams.T = 273.15 + 16;
%x0_tank_clams.h = 0.8;
%x0_tank_tilapia.h = 0.8;

BuildBusFlow

%%
cv_params = cv_p;
%%
set_param('test15','StopTime','tspan(end)')
r = sim('test15');
%%
rl = r.logsout;
%%
var_names = {'WTT','WTM','WTC','WTS'};
clear WT
for ivar = var_names 
x = rl.getElement(ivar{:});
WT.(ivar{:}) = parseTank(x,r.tout);
end
%%
rdate = DateTime(1) + days(r.tout);
%%
figure(1)
clf
subplot(4,1,1)
hold on
iter = 0;

for ivar = var_names
    iter = iter + 1;
    plot(rdate,WT.(ivar{:}).Fout.T-273.15)
end
ylim([9 19])

yyaxis right
IC = rl.getElement('IC');
IC_st = parseIndoorClimate(IC,r.tout);
plot(rdate,IC_st.Temp.Tair-273.15)
legend(var_names)
%
subplot(4,1,2)

hold on
plot(DateTime,Tw_tilapia-273.15)
plot(DateTime,Tw_mullet-273.15)
plot(DateTime,Tw_clams-273.15)
plot(DateTime,Tw_sedim-273.15)
ylim([9 19])
yyaxis right
plot(DateTime,Ti_GH3-273.15)
plot(rdate,IC_st.Temp.Tair-273.15)

legend(var_names)
%
subplot(4,1,3)
iter = 0;
hold on
H_fg = 2437000; % J/kg
for ivar = var_names
    iter = iter + 1;
    plot(rdate,WT.(ivar{:}).QT/H_fg)
end
yyaxis right
plot(DateTime,HR_GH3)
%
subplot(4,1,4)
hold on
for ivar = var_names
    iter = iter + 1;
    plot(rdate,WT.(ivar{:}).V)
end