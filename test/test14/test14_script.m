clear 
load('CS1_2_renile')

data = data(1:end-100,:);
%% External Climate
DateTime = data.DateTime;
tspan = days(DateTime - DateTime(1));
Te = 273.15 + data.ambient_temp_Biological_filter_P_5;
Re = data.Rad;
He = data.ambinet_Humi_Biological_filter_P_5;
Ve = data.Rad*0 + 0.5;
%% Indoor CLimate
Ti_GH1 = data.ambient_temp_NFT_P_9;
Ti_GH2 = data.ambient_temp_RT_P_6;
Ti_GH3 = data.ambient_temp_Fish_Pond_P_1;

%%
climate = [];
climate.signals.values = [Te Re He Ve];
climate.signals.dimensions = 4;
climate.time = tspan;
%%
p_climate = climate_p;
x0_climate = climate_ic;
%%
r = sim('test14');
%%
rl = r.logsout;
%%
IC = rl.getElement('Indoor Climate');
IC_st = parseIndoorClimate(IC,r.tout);
%%
OC = rl.getElement('Outdoor Climate');
OC_st = parseIndoorClimate(OC,r.tout);
%%
clf
hold on
plot(r.tout,IC_st.Temp.Tair)
%
plot(tspan,Ti_GH1 + 273.15)

plot(r.tout,OC_st.Temp)

xlim([r.tout(1) r.tout(end)])
legend('T_i^{sim}','T_i^{GH1}','T_{e}')