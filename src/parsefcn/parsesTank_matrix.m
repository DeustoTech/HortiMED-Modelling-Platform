function ds_climate = parsesTank_matrix(climate_matrix)

load('RSIM_VARS_NAMES.mat')
%%
ds_climate = array2table(permute(climate_matrix,[3 1 2]),'VariableNames',STANK_NAMES);

end

