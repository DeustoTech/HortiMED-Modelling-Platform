function ds_climate = parseIndoorClimate_matrix(climate_matrix)

load('RSIM_VARS_NAMES.mat')
%%
ds_climate = array2table(permute(climate_matrix,[1 2 3]),'VariableNames',INDOOR_NAMES);

end

