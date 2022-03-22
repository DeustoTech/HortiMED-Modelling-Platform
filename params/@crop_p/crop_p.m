classdef crop_p
    %CL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % N K Ca Mg P S O2 TSS
        Chi_nutrients = [15 10 5 2 2 1 0 0]'/960;
        % area
        A_v = 2080; % cultivated fraction of floor 
        plants_density = 2.1562; % [number of plants/m^2]
        %
        % water 
        fraction_DM = 0.08;
        min_water_capacity = 0.1; % kg{H2O}/m^2
        C_buf_max = 0.02; % kg/m^2
        T_v_start_fruit = 1100; 

        % Fruit Partitioning

        %
        int_air_speed = 0.5; % internal air speed [m/s]        

        % CROP GROWTH MODEL
        % ===================

        % fruit
        rg_fruit  = 0.2e-6;  % potential fruit growth rate coefficient at 20 deg C [kg{CH2O}/m^2/s]
        c_fruit_g = 0.27;    % fruit growth respiration coefficient [-]
        c_fruit_m = 2.3e-7;  % fruit maintenance respiration coefficient [1/s]
        % leaf
        rg_leaf = 0.095e-6;  % potential leaf growth rate coefficient at 20 deg C [kg{CH2O}/m^2/s]
        c_leaf_g = 0.28;     % leaf growth respiration coefficient [-]
        c_leaf_m = 3.47e-7;  % leaf maintenance respiration coefficient [1/s]
        % steam
        rg_stem = 0.074e-6;  % potential stem growth rate coefficient at 20 deg C [kg{CH2O}/m^2/s]
        c_stem_g = 0.30;     % stem growth respiration coefficient [-]
        c_stem_m = 1.47e-7;  % stem maintenance respiration coefficient [1/s]
        %
        T_min_v24 = 14 ;    % between base temperature and first optimal temperature for 24 hour mean [oC]
        T_max_v24 = 27 ;    % between second optimal temperature and maximum temperature for 24 hour mean [oC]
        %
        s_min_T24 = -1.1587; % differential switch function slope for minimum photosynthesis mean 24 hour temperature [1/degC]
        s_max_T24 = 1.3904; % differential switch function slope for maximum photosynthesis mean 24 hour temperature [1/degC]

        b_N_uptake = 0.5;
        %
        T_sum_end = 1035; % the temperature sum at which point the fruit growth rate is maximal [oC]

        s_buforg_buf = -5e3; % differential switch function slope for minimum buffer capacity [m^2/kg]
    
        s_min_T   = -0.8690; % differential switch function slope for minimum photosynthesis instantaneous temperature [1/degC]
        s_max_T = 0.5793; % differential switch function slope for maximum photosynthesis instantaneous temperature [1/degC]
        T_min_v = 6 ; % between base temperature and first optimal temperature [oC]
        T_max_v = 40 ; % between second optimal temperature and maximum temperature [oC]
        
    end

    methods

    end
end

