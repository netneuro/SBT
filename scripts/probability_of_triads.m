function [p] = probability_of_triads(net)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

   [n m] = size (net);
   
    p_a = 0; p_b = 0; p_c = 0; p_d = 0; n_pos =  0; n_neg = 0;
    
    for i = 1:n
        for j=i+1:n
            if net(i,j) == -1
                n_neg = n_neg+1;
            elseif net(i,j) == 1
                n_pos = n_pos+1;
            end
        end
    end
    
    for i=1 : n-2
        for j=i+1 : n-1
            for k= j+1 : n
                switch net(i,j) + net(i,k) + net(j,k)
                    case 1  
                        p_a = p_a+1;
                    case -3
                        p_b = p_b+1;
                    case 3
                        p_c = p_c+1;
                    case -1
                         p_d = p_d+1;
                end
                                       
             end
            
        end
     end
    
    n_triads = p_a + p_b + p_c + p_d;
    total_n_triads = nchoosek(n,3);
    
    if n_triads == total_n_triads
        key = 1;
    else
        key = 0;
    end
    
    p_a = p_a / total_n_triads; p_b = p_b / total_n_triads;
    p_c = p_c / total_n_triads; p_d = p_d / total_n_triads;
    
    p = [n_pos, n_neg, p_a, p_b, p_c, p_d];
%     A = sort (A);
%     
%     save('traid_probabilities.mat', 'A', 'p_a' , 'p_b' , 'p_c', 'p_d', 'total_n_triads', 'n_triads');
%    
end

