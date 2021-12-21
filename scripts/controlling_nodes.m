function [controller_1, controller_2] = controlling_nodes(FC, roi_first_network, roi_second_network)

roi_total = roi_first_network + roi_second_network;

count_controllers_1 = 0;

for i = 1:roi_first_network
    for j = (roi_first_network + 1):(roi_total-1)
        for k = j+1:roi_total
            
            a = FC(i,j);
            b = FC(i,k);
            c = FC(j,k);
            
            if a > 0 && b > 0 && c < 0
                count_controllers_1 = count_controllers_1 + 1;
                controller_1(1, count_controllers_1) = i;
                controller_1(2, count_controllers_1) = j;
                controller_1(3, count_controllers_1) = k;
                controller_1(4, count_controllers_1) = - a * b * c;
            end
        end
    end
end

if count_controllers_1 == 0
    controller_1 = [];
end


count_controllers_2 = 0;

for i = (roi_first_network + 1):(roi_total-1) 
    for j = 1:roi_first_network-1
        for k = j+1:roi_first_network
            
            a = FC(i,j);
            b = FC(i,k);
            c = FC(j,k);
            
            if a > 0 && b > 0 && c < 0
                count_controllers_2 = count_controllers_2 + 1;
                controller_2(1, count_controllers_2) = i;
                controller_2(2, count_controllers_2) = j;
                controller_2(3, count_controllers_2) = k;
                controller_2(4, count_controllers_2) = - a * b * c;
            end
        end
    end
end

if count_controllers_2 == 0
    controller_2 = [];
end
end

