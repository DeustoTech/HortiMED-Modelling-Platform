function ICplots(rdate,IC_st,OC_st,ids,A_span)

Tk = 273.15;

sty = {'LineWidth',2};
subplot(4,1,1)
hold on
plot(rdate,OC_st.Temp - Tk,sty{:},'marker','.','LineStyle','none')
plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')
title("A = " + A_span)
%%
lid = ids.DateTime < rdate(end);

plot(ids.DateTime(lid),ids.Tinv(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')
grid on
yyaxis right
plot(ids.DateTime(lid),ids.Windows(lid),sty{:},'color','k','marker','none','LineStyle','-')
legend('T_e','T_i^{sim}','T_i^{real}','Windows')
xlim([rdate(1) rdate(end)])


subplot(4,1,2)
hold on
plot(ids.DateTime(lid),ids.RadExt(lid),sty{:},'color','b')
plot(ids.DateTime(lid),ids.RadInt(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')
plot(rdate,IC_st.QS.R_int,sty{:},'color','r')

legend('R_e','R_i','R_i^{sim}')
xlim([rdate(1) rdate(end)])


subplot(4,1,3)
hold on
plot(rdate,OC_st.Temp - Tk,sty{:},'marker','.','LineStyle','none')
plot(rdate,IC_st.Temp.Tair - Tk,sty{:},'color','r')

plot(ids.DateTime(lid),ids.Tinv(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')
grid on
yyaxis right
plot(ids.DateTime(lid),ids.EstadoPant1(lid),sty{:})
grid on
legend('T_e','T_i^{sim}','T_i^{real}','Screen')
xlim([rdate(1) rdate(end)])

subplot(4,1,4)
hold on
plot(ids.DateTime(lid),ids.HRInt(lid),sty{:},'color',[1 0.8 0.8],'marker','.','LineStyle','none')
plot(ids.DateTime(lid),ids.HRExt(lid),sty{:},'color','b','marker','.','LineStyle','none')

plot(rdate,IC_st.Gas.HRInt,sty{:},'color','r','LineStyle','-')
yyaxis right
plot(ids.DateTime(lid),ids.Windows(lid),sty{:},'color','k','marker','none','LineStyle','-')
legend('HR_{int}^{real}','HR_{ext}','HR_{int}^{sim}','Windows')
end

