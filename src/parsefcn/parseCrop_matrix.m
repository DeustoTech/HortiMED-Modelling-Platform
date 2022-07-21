function ds_crop = parseCrop_matrix(crop_matrix)

load('RSIM_VARS_NAMES.mat')
%%
ds_crop = array2table(permute(crop_matrix,[3 1 2]),'VariableNames',CROP_NAMES);

end

