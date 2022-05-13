function ICplots(rdate,IC_st,OC_st,CC_st,Crop,Fruit,ds_crop,crop_p)

    Tk = 273.15;

    sty = {'LineWidth',2};
    subplot(2,2,1)
    
    hold on
    plot(ds_crop.DateTime,ds_crop.MatureFruit/crop_p.A_v,'-')
    plot(rdate,(0.965/0.035)*Fruit,sty{:})
    xlim([rdate(1) rdate(end)])
    ylabel('Fresh Fruits(Kg/m^2)')
    title('Harvest')
    grid on
    legend('Real','Simulation','Location','northwest')
    
    %%
    subplot(2,2,2)
    hold on
    plot(rdate,IC_st.Gas.C_c_ppm);
    ylabel('CO_2(ppm)')
    yyaxis right
    plot(rdate,CC_st.Windows.value)
    ylabel('Windows(%)')
    legend('CO_2','Windows')
    xlim([rdate(1) rdate(end)])

    %%
    subplot(2,2,3)
    hold on
    plot(rdate,Crop.Carbon.Cbuff,sty{:})
    plot(rdate,Crop.Carbon.Cfruit,sty{:})
    plot(rdate,Crop.Carbon.Cleaf,sty{:})
    plot(rdate,Crop.Carbon.Cstem,sty{:})
    %plot(rdate,Fruit,sty{:},'color','b')
    xlim([rdate(1) rdate(end)])

    ylabel('C[kg/m^2]')
    grid on
    title('Carbon Dry Mass')
    legend('C_{buffer}','C_{fruit}','C_{leaf}','C_{stem}','Location','west')
    
%     subplot(5,1,4)
%     plot(rdate,Crop.VPD,sty{:})
%     title('Vapor Pressure Deficit')
%     ylabel('VDP[Pa]')
%     grid on
%     xlim([rdate(1) rdate(end)])

    %%
    subplot(2,2,4)
    plot(rdate,Crop.LAI,sty{:})
    grid on
    ylabel('LAI')
    xlim([rdate(1) rdate(end)])

end

