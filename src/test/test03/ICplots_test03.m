function ICplots(rdate,IC_st,OC_st,CC_st)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(3,1,1)
    hold on
    plot(rdate,OC_st.Temp - Tk,sty{:})
    plot(rdate,IC_st.Temp.Tair - Tk,sty{:})
    plot(rdate,IC_st.Temp.Tcover - Tk,sty{:})
    plot(rdate,IC_st.Temp.Tfloor - Tk,sty{:})
    plot(rdate,IC_st.Temp.Tsoil - Tk,sty{:})
    ylim([5 20])
    grid on
    legend('T_e','T_i','T_c','T_s')
    subplot(3,1,2)
    hold on
    plot(rdate,OC_st.HR,sty{:})
    plot(rdate,IC_st.Gas.HRInt,sty{:})
    grid on
    legend('H_e','H_i')
    ylim([40 100])
    subplot(3,1,3)

    plot(rdate,CC_st.Windows,sty{:})
end

