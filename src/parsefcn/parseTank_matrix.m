function ds_climate = parseTank_matrix(climate_matrix)

load('RSIM_VARS_NAMES.mat')
%%
ds_climate = array2table(permute(climate_matrix,[3 1 2]),'VariableNames',TANK_NAMES);

end

