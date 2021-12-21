function [outputArg1,outputArg2] = Hamiltonian(net)

    [n m] = size (net);
    H = 0;
    alpha = 1; gamma = 0.3; omega = 0.1;
    
    for i=1 : n-2
        for j=i+1 : n-1
            for k= j+1 : n
                
                three_body = net (i,j) * net(j,k) * net(k,i);
                two_body = (net(i,j) * net(j,k)) + (net(i,j) * net(k,i))+ (net(j,k) * net(k,i));
                one_body = net(i,j) + net(j,k) + net(k,i);
                
                H = H + (-(alpha * three_body) - (gamma * two_body) + (omega * one_body));
                
            end
            
        end
    end
    
    H
    
%     H = - H / (nchoosek(n,3));
    
end



