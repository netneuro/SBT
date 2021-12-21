
nodes_control_ses2 = zeros(253460, 6);
n_a = 89869;
n_b = 2511;
n_c = 121203;
n_d = 39877;

count_a = 1;
count_b = n_a + 1;
count_c = n_a + n_b + 1;
count_d = n_a + n_b + n_c + 1;

% Type A
    % % Set color
    for i=1: n_a
        nodes_control_ses2(i,4) = 1;
    end
    % % set x,y,z and size
    for i=1:116
        for j=1:116
            for k=1:116
                if ~isnan(x_triads_a_control_ses2(i,j,k)) 

                    nodes_control_ses2(count_a, 1) = x_triads_a_control_ses2(i,j,k);
                    nodes_control_ses2(count_a, 2) = y_triads_a_control_ses2(i,j,k);
                    nodes_control_ses2(count_a, 3) = z_triads_a_control_ses2(i,j,k);

%                     nodes_control_ses2(count_a, 5) = u_a_control_ses2(i,j,k);
                    count_a = count_a + 1;
                end


            end
        end   
    end

    
% Type B
    % % Set color
    for i=count_b:n_a + n_b
        nodes_control_ses2(i,4) = 2;
    end
    % % set x,y,z and size
    for i=1:116
        for j=1:116
            for k=1:116
                if ~isnan(x_triads_b_control_ses2(i,j,k)) 

                    nodes_control_ses2(count_b, 1) = x_triads_b_control_ses2(i,j,k);
                    nodes_control_ses2(count_b, 2) = y_triads_b_control_ses2(i,j,k);
                    nodes_control_ses2(count_b, 3) = z_triads_b_control_ses2(i,j,k);

%                     nodes_control_ses2(count_b, 5) = u_b_control_ses2(i,j,k);

                    count_b = count_b + 1;
                end


            end
        end   
    end

% Type C
    % % Set color
    for i=count_c: n_a + n_b + n_c
        nodes_control_ses2(i,4) = 3;
    end
    % % set x,y,z and size
    for i=1:116
        for j=1:116
            for k=1:116
                if ~isnan(x_triads_c_control_ses2(i,j,k)) 

                    nodes_control_ses2(count_c, 1) = x_triads_c_control_ses2(i,j,k);
                    nodes_control_ses2(count_c, 2) = y_triads_c_control_ses2(i,j,k);
                    nodes_control_ses2(count_c, 3) = z_triads_c_control_ses2(i,j,k);

%                     nodes_control_ses2(count_c, 5) = u_c_control_ses2(i,j,k);

                    count_c = count_c + 1;
                end


            end
        end   
    end

% Type D
    % % Set color
    for i=count_d:n_a + n_b + n_c + n_d
        nodes_control_ses2(i,4) = 4;
    end
    % % set x,y,z and size
    for i=1:116
        for j=1:116
            for k=1:116
                if ~isnan(x_triads_d_control_ses2(i,j,k)) 

                    nodes_control_ses2(count_d, 1) = x_triads_d_control_ses2(i,j,k);
                    nodes_control_ses2(count_d, 2) = y_triads_d_control_ses2(i,j,k);
                    nodes_control_ses2(count_d, 3) = z_triads_d_control_ses2(i,j,k);

%                     nodes_control_ses2(count_d, 5) = u_d_control_ses2(i,j,k);

                    count_d = count_d + 1;
                end


            end
        end   
    end   
   
for i=1:253460
   nodes_control_ses2(i, 5) = 1;
   nodes_control_ses2(i, 6) = 0;
end

    
