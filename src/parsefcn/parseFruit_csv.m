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
                    Y.((i{:})+"__"+(j{:})) = perm(st.(j{:}).Data,Nt);
                    
               else
                   sub_sub_names = fieldnames(st.(j{:}));
                    for k = sub_sub_names'
                        Y.((i{:})+"__"+(j{:})+"__"+(k{:})) = perm(st.(j{:}).(k{:}).Data,Nt);
                    end
               end
           end
       end
    end
    
    for ivar = fieldnames(Y)'
       nrows = size(Y.(ivar{:}),2);
       if nrows>1
          Z =  Y.(ivar{:});
          for irow = 1:nrows
            Y.(ivar{:}+"__"+irow) = Z(:,irow);
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
end

