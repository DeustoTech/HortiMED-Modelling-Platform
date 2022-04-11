clear 
%
main_path = 'HORTISIM.slx';
main_path = which(main_path);
main_path = replace(main_path,'HORTISIM.slx','');
test_path = fullfile(main_path,'test');

%% files 
r = dir(test_path);

for ir = r'
    pause(2)
    if (contains(ir.name,'test').*ir.isdir)
        try 
            open_system(ir.name)
            name_script = ir.name+"_script";
            save('run_all_test_ws')
            eval(name_script)
            load('run_all_test_ws')
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

