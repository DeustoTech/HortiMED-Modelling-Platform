function ICplots(rdate,IC_st,OC_st)

Tk = 273.15;

sty = {'LineWidth',2};
subplot(2,1,1)
hold on
plot(rdate,OC_st.Temp - Tk,sty{:})
plot(rdate,IC_st.Temp.Tair - Tk,sty{:})
plot(rdate,IC_st.Temp.Tcover - Tk,sty{:})
plot(rdate,IC_st.Temp.Tfloor - Tk,sty{:})
plot(rdate,IC_st.Temp.Tsoil - Tk,sty{:})
grid on
legend('T_e','T_i','T_c','T_f','T_s')
subplot(2,1,2)
hold on
plot(rdate,OC_st.HR,sty{:})
plot(rdate,IC_st.Gas.HRInt,sty{:})
grid on
legend('H_e','H_i')

end

