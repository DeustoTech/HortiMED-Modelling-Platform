function ICplots(rdate,IC_st,OC_st,ids)

Tk = 273.15;

sty = {'LineWidth',2};
subplot(2,1,1)
hold on
plot(rdate,OC_st.Temp - Tk,sty{:})
plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')
%%
lid = ids.DateTime < rdate(end);

plot(ids.DateTime(lid),ids.Tinv(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')

grid on
legend('T_e','T_i','T_i^{sim}')
yyaxis right
plot(ids.DateTime(lid),ids.windows(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')


subplot(2,1,2)
hold on
plot(rdate,OC_st.HR,sty{:})
plot(rdate,IC_st.Gas.HRInt,sty{:})
grid on
legend('H_e','H_i')

end

