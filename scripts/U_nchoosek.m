function [U ] = U_nchoosek( FC )
% updated: 22 Dey 98

    [n m] = size (FC);
    U = 0;
    
    for i=1 : n-2
        for j=i+1 : n-1
            for k= j+1 : n
                product = FC (i,j) * FC(i,k) * FC(j,k);
                U = U + product;
            end
            
        end
    end
    num = nchoosek(n,3);
    U = - U / num;
    
end

