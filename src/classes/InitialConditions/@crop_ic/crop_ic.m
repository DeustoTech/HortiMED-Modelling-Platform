classdef crop_ic
    %CLIMATE_IC Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %
        Tv = 273+15;
        %
        %   Buff Fruit Leaf Stem
        C =[0.01   1e-3  1e-2      1e-2]
        R = [0 0 0]
        Tsum  = 0
        C_wv = 0.2;
        N = 1e-5*[0 0 0 0 0 0 0 0]';

    end
    
    methods

    end
end

