classdef tank_p
    %TANK_P Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        S = 10
        h_max = 1
        wall_gain = 1;
        ThermalConductivityWall = 50;
        Tsubwall = 273.15 + 12;
        h = 0.5;       
             %N K Ca Mg P S O2 TSS 
        X (8,1) = [ 1 1 1  1  1 1 10  10]';
        T = 273.15 + 15;
        Twall = 273.15 + 13;
        d_t = 1.5;
    end
    
end

