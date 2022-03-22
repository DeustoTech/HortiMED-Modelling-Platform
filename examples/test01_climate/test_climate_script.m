%%
clear 

%% params
params_test01 = climate_p;
params_test01_st = struct(params_test01);
varsInfo_params = Simulink.Bus.createObject(params_test01_st);

%% Initial Conditions
ic_test01 = climate_ic;
ic_test01 = struct(ic_test01);
varsInfo_ic = Simulink.Bus.createObject(ic_test01);

%%
r = sim('test_climate');