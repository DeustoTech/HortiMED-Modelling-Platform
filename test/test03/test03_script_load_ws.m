clear

load('test03_ws')
%%
new_ods = ods(tspan<r.tout(end),:);
figure(1)
clf
hold on
vars = {'T','R','H','V'}
iter = 0;
for ivar = vars
    iter = iter + 1;
    subplot(2,2,iter)
    plot(new_ods.DateTime,new_ods.(ivar{:}))
    title(ivar{:})
    grid on
end
%%
