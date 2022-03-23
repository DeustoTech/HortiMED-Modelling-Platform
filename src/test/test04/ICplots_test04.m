function ICplots(rdate,IC_st,OC_st,CC_st,win_p,scr_p,src_com_st)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(3,1,1)
    
    hold on
    
    area(rdate,1000*(IC_st.QS.R_int>win_p.RadThreshold)-500,sty{:},'FaceAlpha',0.4,'LineStyle','none')

    plot(rdate,OC_st.Temp - Tk,sty{:},'color','b')
    plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')

    ylim([5 20])
    ylabel('Temperature(K)')

    grid on
    
    legend('day','T_e','T_i')
    
   

    subplot(3,1,2)
    hold on
    plot(rdate,OC_st.Rad,sty{:})
    yline(scr_p.Radthreshold)
    ylim([0 500])
    
    yyaxis right 
    ylim([0 105])
    ylabel('Screen(%)')


    plot(rdate,CC_st.Screen,sty{:},'color','k')
    grid on
    legend('R_i','R_{threshold}','Screen')

    
    subplot(3,1,3)
    hold on
    plot(rdate,src_com_st)
    
    tspan = seconds(rdate-rdate(1));
    ylabel('W')

    yyaxis right 
    plot(rdate,2.77778e-7*cumtrapz(tspan,src_com_st))
    ylabel('kWh')
end

