function [U ] = U_normal(FC)

[n m] = size (FC);
U = 0;
norm = 0;

for i= 1:n-2
    for j = i+1:n-1
        for k = j+1 : n
            product = FC (i,j) * FC(j,k) * FC(k,i);
            U = U + product;
            norm = norm + abs(product);
        end
        
    end
end

U = - U / norm;

end

