function ds_climate = parseControlClimate_matrix(climatecontrol_matrix)

load('RSIM_VARS_NAMES.mat')
%%
ds_climate = array2table(permute(climatecontrol_matrix,[1 2 3]),'VariableNames',CONTROL_NAMES);

end

