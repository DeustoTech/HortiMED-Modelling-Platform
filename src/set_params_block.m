function set_params_block(path_block,structure,name)


params = get_param(path_block,'DialogParameters');
for i = fieldnames(params)'
    name_variable = name+"."+i{:};
    structure.(i{:});
    set_param(path_block,i{:},name_variable)
end

end

