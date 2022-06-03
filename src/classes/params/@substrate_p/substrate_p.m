classdef substrate_p
    %CLIMATE_IC Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Vmax_subs = 10; %% kg{H2O}/m^2 of substrate
        Vmin_subs = 0.01; %% kg{H2O}/m^2  of substrate 
        Nmin_subs = 1e-9;
                C_ws = 1e-1;
        N = 1e-5*[0 0 0 0 0 0 0 0]';

    end
    
    methods

    end
end

 