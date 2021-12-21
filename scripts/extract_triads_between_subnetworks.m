function [new_FC] = extract_triads_between_subnetworks(FC, roi_first_network, roi_second_network)

roi_total = roi_first_network + roi_second_network;
index_first_network = [1, roi_first_network];
index_second_network = [roi_first_network + 1, roi_total];

new_FC = zeros(roi_total, roi_total);

for i = 1:(roi_total - 2)
    for j = i+1:(roi_total - 1)
        for k = j+1:roi_total
            
            a = FC(i,j);
            b = FC(j,k);
            c = FC(k,i);
            
            if a ~= 0 && b ~= 0 && c ~= 0
                
                if (i <= index_first_network(1,2) && j <= index_first_network(1,2) && k <= index_first_network(1,2))
                    % All three nodes of the triad are within the first subnetwork
                    
                elseif (i >= index_second_network(1,1) && j >= index_second_network(1,1) && k >= index_second_network(1,1))
                    % All three nodes of the triad are within the second subnetwork
                    
                else % The triad is in between networks
                    new_FC(i, j) = a; new_FC(j, i) = a;                    
                    new_FC(j, k) = b; new_FC(k, j) = b;
                    new_FC(k, i) = c; new_FC(i, k) = c;
                end                
            end
        end
    end
end

end

