function [U, U_normal] = U_quartic(FC)

[n m] = size (FC);
U = 0;
rectangles_count = 0;
norm = 0;

for i = 1:n-3
    for j = i+1:n-2
        for k = j+1:n-1
            for l = k+1:n
                
                product = 0;
                if FC(i,j) ~= 0 && FC(j,k) ~= 0 && FC(k,l) ~= 0 && FC(l,i) ~= 0 && FC(i,k) == 0 && FC(j,l) == 0
                    product = FC(i,j) * FC(j,k) * FC(k,l) * FC(l,i);
                    rectangles_count = rectangles_count + 1;                   
                    
                elseif FC(i,k) ~= 0 && FC(k,j) ~= 0 && FC(j,l) ~= 0 && FC(l,i) ~= 0 && FC(i,j) == 0 && FC(l,k) == 0
                    product = FC(i,k) * FC(k,j) * FC(j,l) * FC(l,i);
                    rectangles_count = rectangles_count + 1;
                    
                elseif FC(i,j) ~= 0 && FC(j,l) ~= 0 && FC(l,k) ~= 0 && FC(k,i) ~= 0 && FC(i,l) == 0 && FC(j,k) == 0
                    product = FC(i,j) * FC(j,l) * FC(l,k) * FC(k,i);
                    rectangles_count = rectangles_count + 1;
                end
                
                U = U + product;
                norm = norm + abs(product);
                
            end
        end       
    end
end

U = - U / rectangles_count;
U_normal = - U / norm;

end



