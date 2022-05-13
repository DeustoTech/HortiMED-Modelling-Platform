function ICplots(rdate,IC_st,OC_st,Crop)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(4,1,1)
    
    hold on
    

    plot(rdate,OC_st.Temp - Tk,sty{:},'color','b')
    plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')

    ylim([-5 20])
    ylabel('T(K)')
    title('Temperature')
    grid on
    
    legend('T_e','T_i')
    
  
    
    subplot(4,1,2)
    hold on
    plot(rdate,Crop.Carbon.Cbuff,sty{:})
    plot(rdate,Crop.Carbon.Cfruit,sty{:})
    plot(rdate,Crop.Carbon.Cleaf,sty{:})
    plot(rdate,Crop.Carbon.Cstem,sty{:})
    ylabel('C[kg/m^2]')
    grid on
    title('Carbon Dry Mass')
    legend('C_{buffer}','C_{fruit}','C_{leaf}','C_{stem}')
    
    subplot(4,1,3)
    plot(rdate,Crop.VPD,sty{:})
    title('Vapor Pressure Deficit')
    ylabel('VDP[Pa]')
    grid on
    
    subplot(4,1,4)
    plot(rdate,Crop.WaterPercent*100,sty{:})
    ylabel('%')
    title('Water Percent inside Crop')
    grid on
end

