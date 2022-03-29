function ICplots(rdate,IC_st,OC_st,Crop,Fruit,ds_crop,crop_p)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(4,2,1)
    
    hold on
    plot(ds_crop.DateTime,ds_crop.MatureFruit/crop_p.A_v)
    plot(rdate,(0.965/0.035)*Fruit,sty{:})
    ylabel('Fresh Fruits(Kg)')
    title('Harvest')
    grid on
    
    
    %%
    
    subplot(4,2,3)
    hold on
    plot(rdate,Crop.Carbon.Cbuff,sty{:})
    plot(rdate,Crop.Carbon.Cfruit,sty{:})
    plot(rdate,Crop.Carbon.Cleaf,sty{:})
    plot(rdate,Crop.Carbon.Cstem,sty{:})
    plot(rdate,Fruit,sty{:},'color','b')

    ylabel('C[kg/m^2]')
    grid on
    title('Carbon Dry Mass')
    legend('C_{buffer}','C_{fruit}','C_{leaf}','C_{stem}','C_{fruit}^{mature}')
    
    subplot(4,2,5)
    plot(rdate,Crop.VPD,sty{:})
    title('Vapor Pressure Deficit')
    ylabel('VDP[Pa]')
    grid on
    
    subplot(4,2,7)
    plot(rdate,Crop.WaterPercent*100,sty{:})
    ylabel('%')
    title('Water Percent inside Crop')
    grid on
    subplot(4,2,8)
    plot(rdate,Crop.LAI,sty{:})

end

