function [segregators_T0, segregators_T2, segregators_T1_SN_EN, segregators_T1_SN_DMN, segregators_T1_EN_DMN, segregators_T3] = segragating_triads(network)

count_T0 = 1;
count_T2 = 1;
count_T1_SN_EN = 1;
count_T1_SN_DMN = 1;
count_T1_EN_DMN = 1;
count_T3 = 1;

for i = 1:51 % on SN
    for j = 52:112 % on EN
        for k = 113:191 % on DMN
            
            if network(i, j) < 0 && network(j, k) < 0 && network(k, i) < 0
                
                segregators_T0(1, count_T0) = - network(i, j) * network(j, k) * network(k, i);
                count_T0 = count_T0 + 1;
                
            elseif network(i, j) > 0 && network(j, k) < 0 && network(k, i) > 0
                
                segregators_T2(1, count_T2) = - network(i, j) * network(j, k) * network(k, i);
                count_T2 = count_T2 + 1;
                
            elseif network(i, j) > 0 && network(j, k) < 0 && network(k, i) < 0
                
                segregators_T1_SN_EN(1, count_T1_SN_EN) = - network(i, j) * network(j, k) * network(k, i);
                count_T1_SN_EN = count_T1_SN_EN + 1;
                
            elseif network(i, j) < 0 && network(j, k) < 0 && network(k, i) > 0
                
                segregators_T1_SN_DMN(1, count_T1_SN_DMN) = - network(i, j) * network(j, k) * network(k, i);
                count_T1_SN_DMN = count_T1_SN_DMN + 1;
                
            elseif network(i, j) < 0 && network(j, k) > 0 && network(k, i) < 0
                
                segregators_T1_EN_DMN(1, count_T1_EN_DMN) = - network(i, j) * network(j, k) * network(k, i);
                count_T1_EN_DMN = count_T1_EN_DMN + 1;
                
            elseif network(i, j) > 0 && network(j, k) > 0 && network(k, i) > 0
                
                segregators_T3(1, count_T3) = - network(i, j) * network(j, k) * network(k, i);
                count_T3 = count_T3 + 1;
                
            end
        end
    end
end

end

