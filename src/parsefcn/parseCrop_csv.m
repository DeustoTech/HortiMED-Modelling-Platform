function Y = parseCrop(X,tout)

    Nt = length(tout);
    names = fieldnames(X.Values);
    
    Y = [];
    for i = names'
       st = X.Values.(i{:});
       if isa(st,'timeseries')
           Y.(i{:}) = perm(st.Data,Nt);
           
       else
           sub_names = fieldnames(st);
           for j = sub_names'
               if isa(st.(j{:}),'timeseries')
                    Y.((i{:})+"_"+(j{:})) = perm(st.(j{:}).Data,Nt);
                    
               else
                   sub_sub_names = fieldnames(st.(j{:}));
                    for k = sub_sub_names'
                        Y.((i{:})+"_"+(j{:})+"_"+(k{:})) = perm(st.(j{:}).(k{:}).Data,Nt);
                    end
               end
           end
       end
    end
    
    
    Water = Y.("Water_WaterState_VegWater");
    
    f_CBuff = Y.("Carbon_Cbuff")./Y.C_Total;
    f_Cfruit = Y.("Carbon_Cfruit")./Y.C_Total;
    f_Cleaf = Y.("Carbon_Cleaf")./Y.C_Total;
    f_Cstem = Y.("Carbon_Cstem")./Y.C_Total;
    
    Y.("Water_Distribution_Cbuff")  = Water.*f_CBuff;
    Y.("Water_Distribution_Cfruit") = Water.*f_Cfruit;
    Y.("Water_Distribution_Cleaf")  = Water.*f_Cleaf;
    Y.("Water_Distribution_Cstem")  = Water.*f_Cstem;

    % 
    for ivar = fieldnames(Y)'
       nrows = size(Y.(ivar{:}),2);
       if nrows>1
          Z =  Y.(ivar{:});
          for irow = 1:nrows
            Y.(ivar{:}+"_"+irow) = Z(:,irow);
          end
          Y = rmfield(Y,ivar{:});
       end
    end
end



function Y = perm(X,Nt) 

    indexs = [1 2 3];
     if length(size(X)) > 2
         first  = indexs(size(X) == Nt);
         second = indexs(size(X) ~= Nt);
         Y = permute(X,[first second]);
     else
         Y = X;
     end
     
     if length(X) == 1
         Y= Y +zeros(Nt,1);
     end
end

