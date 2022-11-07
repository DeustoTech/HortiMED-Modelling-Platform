function set_params_block(path_block,structure)
% 
% Esta funcion cambia el nombre de los parametros de un bloque simulink de
% la libreria HORTISIM. De manera que path_block nos identifica el bloque
% el cual queremos modificar, mientras que struture es la variable que
% queremos que se fije. 
%
% Input Variables: 
% ----------------
%   -  path_block: Direccion del bloque Simulink 
%   -  struture: Structura fuente que se usara para fijar las nuevas variables
%               en los parametros del bloque
%%
% Fecha: 30 de Agosto de 2022
% Autor: Deyviss Jesus Oroya
% --------------------------------
%%

name = inputname(2);

params = get_param(path_block,'DialogParameters');
for i = fieldnames(params)'
    name_variable = name+"."+i{:};
    structure.(i{:});
    set_param(path_block,i{:},name_variable)
end

end

