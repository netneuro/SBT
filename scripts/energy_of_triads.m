function [u_T2, u_T0, u_T3, u_T1] = energy_of_triads(FC, roi, network_type)

roi_total = sum(roi);
if network_type >= 2
    roi_1 = roi(1, 1);
    roi_2 = roi(1, 2);
end

u_T2 = zeros(roi_total, roi_total, roi_total);
u_T0 = zeros(roi_total, roi_total, roi_total);
u_T3 = zeros(roi_total, roi_total, roi_total);
u_T1 = zeros(roi_total, roi_total, roi_total);

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
            if interaction(i ,j, k)
                a = FC(i, j);
                b = FC(j, k);
                c = FC(k, i);
                energy = -(a * b * c);
                if (a ~= 0 && b ~= 0 && c ~= 0)
                    if a > 0, a = 1; elseif a < 0, a = -1; end
                    if b > 0, b = 1; elseif b < 0, b = -1; end
                    if c > 0, c = 1; elseif c < 0, c = -1; end
                    
                    switch (a + b + c)
                        case 1 % T2: + + -
                            u_T2(i, j, k) = energy;
                        case -3 % T0: - - -
                            u_T0(i, j, k) = energy;
                        case 3 % T3: + + +
                            u_T3(i, j, k) = energy;
                        case -1 % T1: + - -
                            u_T1(i, j, k) = energy;
                    end
                end
            end
        end
    end
end

end


