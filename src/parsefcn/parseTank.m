function Y = parseTank(X,tout)

    Nt = length(tout);
    names = fieldnames(X.Values);
    
    Y = [];
    for i = names'
       st_tot = X.Values.(i{:});
       n_st = length(st_tot);
       for nn_st = 1:n_st
           st = st_tot(nn_st);
           if isa(st,'timeseries')
               try
                    Y.(i{:})(nn_st) = perm(st.Data,Nt);
               catch
                    Y.(i{:}) = perm(st.Data,Nt);
               end
           else
               sub_names = fieldnames(st);
               for j = sub_names'
                   if isa(st.(j{:}),'timeseries')
                       try
                        Y.(i{:})(nn_st).(j{:}) = perm(st.(j{:}).Data,Nt);
                       catch
                        Y.(i{:}).(j{:}) = perm(st.(j{:}).Data,Nt);
                       end
                    else
                       sub_sub_names = fieldnames(st.(j{:}));
                        for k = sub_sub_names'
                            Y.(i{:}).(j{:}).(k{:})(nn_st) = perm(st.(j{:}).(k{:}).Data,Nt);
                        end
                   end
               end
           end
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
end

