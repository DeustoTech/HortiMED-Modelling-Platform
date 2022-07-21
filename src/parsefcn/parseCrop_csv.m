function X = parseCrop(X,tout)

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
    
 
    % 
    iter = 0;
    fn = fieldnames(Y)';
    X = [];
    for ivar = fn
       iter = iter + 1;
       nrows = size(Y.(ivar{:}),2);
       if nrows>1
          Z =  Y.(ivar{:});
          for irow = 1:nrows
            X.(ivar{:}+"_"+irow) = Z(:,irow);
          end
       else
           X.(ivar{:}) = Y.(ivar{:});
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

