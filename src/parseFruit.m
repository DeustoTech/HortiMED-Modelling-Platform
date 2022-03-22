function Y = parseFruit(Crop,Fruits,tout)

    Nt = length(tout);
    names = fieldnames(Fruits.Values);
    
    Y = [];
    for i = names'
       st = Fruits.Values.(i{:});
       if isa(st,'timeseries')
           Y.(i{:}) = perm(st.Data,Nt);
           
       else
           sub_names = fieldnames(st);
           for j = sub_names'
               if isa(st.(j{:}),'timeseries')
                    Y.(i{:}).(j{:}) = perm(st.(j{:}).Data,Nt);
                    
               else
                   sub_sub_names = fieldnames(st.(j{:}));
                    for k = sub_sub_names'
                        Y.(i{:}).(j{:}).(k{:}) = perm(st.(j{:}).(k{:}).Data,Nt);
                    end
               end
           end
       end
    end
    
    Water = Crop.Water.Distribution.Cfruit;
    
    
    all = [Y.Cf0 Y.Cfs];
    Y.Cf_all = all;
    
    all_in_plant = all(:,1:end-1);
    f = all./sum(all,2);
    
    
    Y.Cf_fresh = Water.*f;
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
end

