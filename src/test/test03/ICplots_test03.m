function ICplots(rdate,IC_st,OC_st,CC_st,win_p,win_com_st)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(4,1,1)
    
    hold on
    
    area(rdate,1000*(IC_st.QS.R_int>win_p.RadThreshold)-500,sty{:},'FaceAlpha',0.4,'LineStyle','none')

    plot(rdate,OC_st.Temp - Tk,sty{:},'color','b')
    plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')
    plot(rdate,IC_st.Temp.Tair*0 + 12,'--')
    plot(rdate,IC_st.Temp.Tair*0 + 18,'--')
    ylim([5 20])
    ylabel('Temperature(K)')

    yyaxis right 
    ylim([-5 105])
    ylabel('Windows(%)')

    plot(rdate,CC_st.Windows.Value,sty{:},'color','k')
    grid on
    
    legend('day','T_e','T_i','T_{start}','T_{max}','Windows')
    
    
    subplot(4,1,2)
    hold on
    area(rdate,1000*(IC_st.QS.R_int>win_p.RadThreshold)-500,sty{:},'FaceAlpha',0.4,'LineStyle','none')

    plot(rdate,OC_st.HR,sty{:},'color','b')
    plot(rdate,IC_st.Gas.HRInt,sty{:},'color','r')
    plot(rdate,IC_st.Temp.Tair*0 + 80,'--')
    plot(rdate,IC_st.Temp.Tair*0 + 90,'--')
    ylim([20 100])
    ylabel('HR(%)')
    yyaxis right 
    plot(rdate,CC_st.Windows.Value,sty{:},'color','k')
    ylabel('Windows(%)')
    ylim([0 50])
    grid on
    legend('day','H_e','H_i','H_{start}','H_{max}','Windows')
    ylim([-5 105])

    subplot(4,1,3)
    hold on
    area(rdate,5000*(IC_st.QS.R_int>win_p.RadThreshold)-2500,sty{:},'FaceAlpha',0.4,'LineStyle','none')
    plot(rdate,IC_st.QS.R_int,sty{:})
    yline(win_p.RadThreshold,sty{:})
    legend('day','R_i','R_i^{Threshold}')
    ylim([0 500])
    
    subplot(4,1,4)
    hold on
    plot(rdate,win_com_st)
    
    tspan = seconds(rdate-rdate(1));
    ylabel('W')

    yyaxis right 
    plot(rdate,2.77778e-7*cumtrapz(tspan,win_com_st))
    ylabel('kWh')
end

