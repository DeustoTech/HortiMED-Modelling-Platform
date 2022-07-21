classdef substrate_p
    %CLIMATE_IC Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Vmax_subs = 10; %% kg{H2O}/m^2 of substrate
        Vmin_subs = 0.01; %% kg{H2O}/m^2  of substrate 
        Nmin_subs = 1e-9;
        C_ws = 1e-1;
        N (8,1)= 1e-6*ones(8,1);
        DraingeConst = 1e-2;
        sigma_max = 1
        sigma_min = 1
    end
    
    methods

    end
end

 