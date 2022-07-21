function r = parseTable2Struct(ds)

names = ds.Properties.VariableNames;

for ivar = names
   if contains(ivar{:},'Nutrients')||contains(ivar{:},'Drainge__X')||contains(ivar{:},'Mass_')
      continue 
   end
   subnames = replace(ivar{:},'__','.');
   eval(['r.',subnames,' = ds.',ivar{:},';'])

end

try
r.Nutrients.Mass = ds{:,"Nutrients__Mass_"+(1:8)'};
end
try
r.Nutrients.Demand = ds{:,"Nutrients__Demand_"+(1:8)'};
end
try
r.Drainge.X = ds{:,"Drainge__X_"+(1:8)'};
end
try
r.Mass = ds{:,"Mass_"+(1:8)'};
end

end