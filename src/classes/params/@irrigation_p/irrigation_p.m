classdef irrigation_p
    %CL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        hour0  = 1
        IrrigationFlow = 1e-3
        Xnutrients =  0.13*1e-4*[1.0000    0.6667    0.3333    0.1333    0.1333    0.0667         0         0]
        percent_irrigation = 5
        Irrigation_jules_to_hours = 0.5*1e-6
    end
    
    methods
        

    end
end

