classdef climate_p
    %CL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        H = 7; % hieght greenhouse [m]
        A_f = 3200; % greenhouse floor area [m^2]
        A_c = 3200;
        gamma_max = 0.3;
        %%
        lam_s  = [2.5    0.85 ];  % thermal conductivity of soil layers [W/mK] Concrete, Soil, Clay
        c_s    = [1081   1081];   % specific heat of soil layers [J/kgK]
        l_s    = [0.1    0.1 ];   % thickness of soil layers [m]
        rhod_s = [2600   2500 ];  % density of soil layers [kg/m^3] alphS_s=0.5; %solar absorptance of floor [-]

        AR = 15 % m^2 size of windows

        % AIR CHARACTERISTICS
        % ===================
        int_air_speed = 0.5; % internal air speed [m/s]        

        % Solar coeficient
        % =====================
        %  
        alpha_i = 0.1;
        alpha_c = 0.05; % solar absorptivity, taking 'perpendicular' values [-]
        tau_c   = 0.90; % visible transmissivity of cover [-] 
        alpha_f = 0.1; %solar absorptance of floor [-]
        %

        d_c = 1.5; % characteristic length of cover [m]
        cd_c = 8736; % cover heat capacity per unit area [J/m^2/K]

        % FLOOR 
        % =====================
        T_ss   = 12.0 + 273.15; %deep soil temperature [K]


    end
    
    
    properties (Dependent)
      V
   end
    methods
        
        function value = get.V(obj)
            value = obj.H*obj.A_f;
        end
    end
end

