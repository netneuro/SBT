function [U] = U(FC, roi, network_type)

roi_total = sum(roi);
if network_type >= 2
    roi_1 = roi(1, 1);
    roi_2 = roi(1, 2);
end
count_triads = 0;
U = 0;

interaction = ones(roi_total, roi_total, roi_total); % Single network

for i = 1:roi_total-2
    for j = i+1:roi_total-1
        for k = j+1:roi_total
            switch network_type % For networks with more than 2 subnet, set the interactions that are limited within a subnetwork to zero
                case 2
                    if (i <= roi_1 && j <= roi_1 && k <= roi_1) ||... % i, j and k are all in the 1st subnet
                            (i > roi_1 && j > roi_1 && k > roi_1) % i, j and k are all in the 2nd subnet
                        interaction(i, j, k) = 0;
                    end
                case 3
                    if (i <= roi_1 && j <= roi_1 && k <= roi_1) ||... % i, j and k are all in the 1st subnet
                            ((i > roi_1 && i <= (roi_1 + roi_2)) && (j > roi_1 && j <= (roi_1 + roi_2)) && (k > roi_1 && k <= (roi_1 + roi_2))) ||... % i, j and k are all in the 2nd subnet
                            (i > (roi_1 + roi_2) && j > (roi_1 + roi_2) && k > (roi_1 + roi_2)) % i, j and k are all in the 3rd subnet
                        interaction(i, j, k) = 0;
                    end
            end
            if interaction(i , j, k)          
                product = FC(i, j) * FC(j, k) * FC(k, i);
                U = U + product;
                if product ~= 0
                    count_triads = count_triads + 1;
                end
            end          
        end
    end
end

U = - U / count_triads;
  
end



