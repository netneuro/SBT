function [p_a, p_b, p_c, p_d] = probability_of_traids2(net)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

   [n m] = size (net);
   
    n_a = 0; n_b = 0; n_c = 0; n_d = 0;
    n_e = 0; n_f = 0; n_g = 0; n_h = 0;
    n_i = 0; n_j = 0;
    
    p_a = 0; p_b = 0; p_c = 0; p_d = 0;
    p_e = 0; p_f = 0; p_g = 0; p_h = 0;
    p_i = 0; p_j = 0; 
    
    neg_links = 0; inactive_links = 0; pos_links = 0;
    for i = 1:n
        for j=i+1:n
            if net(i,j) == -1
                neg_links = neg_links+1;
            elseif net(i,j) == 1
                pos_links = pos_links+1;
            elseif net(i,j) == 0
                inactive_links = inactive_links +1;               
            end
        end
    end
   
    total_links = pos_links+neg_links+inactive_links;
    
    if nchoosek(n, 2) == total_links 
        flag_links = 1;
    else
        flag_links = 0;
    end
    
    
    for i=1 : n-2
        for j=i+1 : n-1
            for k= j+1 : n
                
                switch net(i,j) + net(i,k) + net(j,k)
                    
                    case 0  
                        if net(i,j)==0 && net(j,k)==0 && net(i,k)==0
                            n_j = n_j+1;
                        else
                            n_e = n_e+1;
                        end
                        
                    case 1  
                       if net(i,j) * net(j,k) * net(i,k) == 0
                            n_h = n_h+1;
                        else
                            n_a = n_a+1;
                       end
                       
                    case -1
                        if net(i,j) * net(j,k) * net(i,k) == 0
                            n_i = n_i+1;
                        else
                            n_d = n_d+1;
                        end
                        
                    case 2
                        n_f = n_f+1;
                    case -2
                        n_g = n_g+1;
                    
                    case 3
                        n_c = n_c+1;
                    case -3
                        n_b = n_b+1;                                                    
                end
            
            end
        end
    end
    
    n_scanned_traids = n_a + n_b + n_c + n_d + n_e + n_f + n_g + n_h + n_i + n_j;
    n_actual_traids = nchoosek(n,3);
    
    if n_scanned_traids == n_actual_traids
        flag = 1;
    else
        flag = 0;
    end
    
    p_a = n_a / n_actual_traids; p_b = n_b / n_actual_traids;
    p_c = n_c / n_actual_traids; p_d = n_d / n_actual_traids;
    p_e = n_e / n_actual_traids; p_f = n_f / n_actual_traids;
    p_g = n_g / n_actual_traids; p_h = n_h / n_actual_traids;
    p_i = n_i / n_actual_traids; p_j = n_j / n_actual_traids;
    
    % extracted traidic energy
   
%     e_a = -log (p_a / 3); e_b = -log (p_b / 1); e_c = -log (p_c / 1); e_d = -log (p_d / 3); 
%     e_e = -log (p_e / 6); e_f = -log (p_f / 3); e_g = -log (p_g / 3); e_h = -log (p_h / 3); 
%     e_i = -log (p_i / 3); e_j = -log (p_j / 1); 
%     
%     results = { '++-','---','+++','+--','.+-','.++','.--','..+','..-','...'; ...
%                  n_a n_b n_c n_d n_e n_f n_g n_h n_i n_j;...
%                  p_a p_b p_c p_d p_e p_f p_g p_h p_i p_j;...
%                  e_a e_b e_c e_d e_e e_f e_g e_h e_i e_j;...
%                  '- links','+ links','. links','total links','','','','','','';...
%                  neg_links , pos_links, inactive_links,total_links,0,0,0,0,0,0}; 
%     
 
%     [B A] = sort (A);
%     p_a
%     p_b
%     p_c
%     p_d
%     p_e
%     p_f
%     p_g
%     p_h
%     p_i
%     p_j

%     save('traid_probabilities.mat','results', 'flag', 'neg_links', 'pos_links', 'inactive_links');
%    save('traid_probabilities.mat','results', 'flag', 'flag_links');
end

