
function [ net_a, net_b, net_c, net_d] = split_network( FC )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    [n m] = size (FC);
    net_a = zeros(n, n);
    net_b = zeros(n, n);
    net_c = zeros(n, n);
    net_d = zeros(n, n);
    
    for i=1 : n-2
        for j=i+1 : n-1
            for k= j+1 : n
                a = FC(i,j);
                b = FC(j,k);
                c = FC(i,k);
                
                if a~= 0 && b~=0 && c~=0
                    if a>0
                        a = 1;
                    elseif a<0 
                        a = -1;
                    end

                    if b>0
                        b = 1;
                    elseif b<0 
                        b = -1;
                    end

                    if c>0
                        c = 1;
                    elseif c<0 
                        c = -1;
                    end


                    switch a+b+c

                        case 1  
    %                       A:  + + -
                        net_a(i,j) = FC (i,j); net_a(i,k) = FC (i,k); net_a(j,k) = FC (j,k); 

                        case -3
    %                       B:  - - -
                        net_b(i,j) = FC (i,j); net_b(i,k) = FC (i,k); net_b(j,k) = FC (j,k); 

                        case 3
    %                       C:  + + +
                        net_c(i,j) = FC (i,j); net_c(i,k) = FC (i,k); net_c(j,k) = FC (j,k); 

                        case -1
    %                       D:  + - -
                        net_d(i,j) = FC (i,j); net_d(i,k) = FC (i,k); net_d(j,k) = FC (j,k); 

                     end

                end
            end
        end
    end
    
    
end

