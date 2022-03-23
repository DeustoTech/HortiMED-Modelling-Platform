
p.f = 0;
p.T = 273.15;
p.X = zeros(8,1);
%
TestObject=Simulink.Bus.createObject(p);
FLOW=eval(TestObject.busName); 
%
clear -regexp slBus*;clear TestObject; 


