clear
load('test18_ws')
%
rdate = t0 + days(r.tout);
tend = rdate(end);
%
indx = find(ids.DateTime < tend);
indx = indx(1):10:indx(end);
%%
figure(1)

clf
subplot(3,1,1)
hold on
plot(rdate,IC_st.Temp.Tair,'Color','r')
plot(ids.DateTime(indx),ids.Tinv(indx),'.','Color','r')
plot(rdate,CE_st.Temp,'Color','b')
%yyaxis right
%plot(rdate,CE_st.Rad,'Color','y')

%legend('T_i^{sim}','T_i^{real}','T_e','R_e')
grid on
legend('T_i^{sim}','T_i^{real}','T_e')
title('Temperature')

xlim([rdate(1) rdate(end)])
subplot(3,1,2)
plot(rdate,CC_st.Windows.value,'-')
xlim([rdate(1) rdate(end)])
title('Windows')
subplot(3,1,3)
hold on
plot(rdate,CE_st.Rad,'Color','b')
plot(rdate,IC_st.QS.R_int,'Color','r')
plot(ids.DateTime(indx),ids.RadInt(indx),'.','Color','r')
xlim([rdate(1) rdate(end)])

%%
figure(2)
clf
ICplots_test01(rdate,IC_st,CE_st)