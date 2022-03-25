function ICplots(rdate,IC_st,OC_st,heater2greenhouse,Th,hconsump)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(3,1,1)
    
    hold on
    

    plot(rdate,OC_st.Temp - Tk,sty{:},'color','b')
    plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')
    plot(rdate,Th - Tk,'color',[255,69,0]/256)

    ylim([-5 20])
    ylabel('Temperature(K)')

    grid on
    
    legend('T_e','T_i','T_{heater}')
    
  
    
    subplot(3,1,2)
    hold on
    plot(rdate,1e-3*hconsump,sty{:})
    tspan = seconds(rdate-rdate(1));
    ylabel('kW')

    yyaxis right 
    plot(rdate,2.77778e-7*cumtrapz(tspan,hconsump),sty{:})
    ylabel('kWh')
    
    subplot(3,1,3)
    plot(rdate,heater2greenhouse,sty{:})

end

