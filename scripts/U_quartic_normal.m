function [U] = U_quartic_normal(FC)

[n m] = size (FC);
U = 0;
norm = 0;

for i = 1:n-3
    for j = i+1:n-2
        for k = j+1:n-1
            for l = k+1:n
   
                config_1 = FC(i,j) * FC(j,k) * FC(k,l) * FC(l,i);
                config_2 = FC(j,k) * FC(k,i) * FC(i,l) * FC(l,j);
                config_3 = FC(i,j) * FC(j,l) * FC(l,k) * FC(k,i);
                
                product = 0;
                
                if config_1 ~= 0
                    product = config_1;
                elseif config_2 ~= 0
                    product = config_2;
                elseif config_3 ~= 0 
                    product = config_3;
                end
                U = U + product;
                norm = norm + abs(product);
                
            end
        end
        
    end
end

U = - U / norm;

end



