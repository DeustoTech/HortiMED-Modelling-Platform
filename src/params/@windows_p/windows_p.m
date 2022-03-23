classdef windows_p
    %CL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        Power  = 100 % [W/(%/s)]
        max_night = 10; % - HR 10%
        tau = 10*(60) % 5min -> 5*60 * sec
        RadThreshold = 10;
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

