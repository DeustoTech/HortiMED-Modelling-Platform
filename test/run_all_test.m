clear 
%
main_path = 'HORTISIM.slx';
main_path = which(main_path);
main_path = replace(main_path,'HORTISIM.slx','');
test_path = fullfile(main_path,"test/"+"climate");

%% files 
r = dir(test_path);
%%
nstart = 4;
for ir = r(nstart:end)'
    pause(2)
    if (contains(ir.name,'test').*ir.isdir)
        try 
            open_system(ir.name)
            name_script = ir.name+"_script";
            save('run_all_test_ws')
            eval(name_script)
            load('run_all_test_ws')
            fprintf("test "+ir.name+"\n")
            try
               close(ir.name)
            catch 
                 'already closed'
            end
        catch
           load('run_all_test_ws')
           error(ir.name + "| no pass test")
        end
    end
end

