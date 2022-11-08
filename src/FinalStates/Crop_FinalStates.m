function r = Crop_FinalStates(Crop)

r.C =  [Crop.Carbon.Cbuff(end)   ... 
        Crop.Carbon.Cfruit(end)  ...
        Crop.Carbon.Cleaf(end)   ...
        Crop.Carbon.Cstem(end)];
    
r.R = [Crop.Relative.Rfruit(end) ...
       Crop.Relative.Rleaf(end) ...
       Crop.Relative.Rstem(end) ];
r.Tsum = Crop.Tsum(end);
r.N = Crop.Nutrients.Mass(end,:)';
r.Tv = Crop.HeatVars.Tveg(end);
r.C_wv = Crop.Water.WaterState.VegWater(end);

end

