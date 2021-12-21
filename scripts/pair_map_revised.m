
% 22 Azar  98

% revised pair map: calls pair_map_rect function
%clear all
%load('z_mean_FDRcorrected.mat');

u = z_ensamble_right_con_14_18_dis;
index = 1;

for i=1:42
    for j=i+1:43
        for k=j+1:44
            if u(i,j)~=0 && u(i,k)~=0 && u(j,k)~=0
                for z=k+1:45
                    if u(i,z)~=0 && u(j,z)~=0 && u(k,z)==0
                        %1
                         x(1, index) = -(u(i,j)*u(i,k)*u(j,k));
                         y(1, index) = -(u(i,j)*u(i,z)*u(j,z));
                         place(1,index) = i; place(2,index) = j; 
                         place(3,index) = k; place(4,index) = z;                          
                         index = index + 1;
                    elseif u(i,z)~=0 && u(k,z)~=0 && u(j,z)==0
                        %2
                         x(1, index) = -(u(i,j)*u(i,k)*u(j,k));
                         y(1, index) = -(u(i,k)*u(i,z)*u(k,z));
                         place(1,index) = i; place(2,index) = j; 
                         place(3,index) = k; place(4,index) = z; 
                         index = index + 1;
                    elseif u(j,z)~=0 && u(k,z)~=0 && u(i,z)==0
                        %4
                         x(1, index) = -(u(i,j)*u(i,k)*u(j,k));
                         y(1, index) = -(u(j,z)*u(j,k)*u(k,z));
                         place(1,index) = i; place(2,index) = j; 
                         place(3,index) = k; place(4,index) = z;
                         index = index + 1;
                    end
                end
            elseif u(i,j)~=0 && u(i,k)~=0 && u(j,k)==0 || u(i,j)==0 && u(i,k)~=0 && u(j,k)~=0 || u(i,j)~=0 && u(i,k)==0 && u(j,k)~=0
                for z=k+1:45
                    if u(z,i)~=0 && u(z,j)~=0 && u(z,k)~=0
                        if u(i,j)~=0 && u(i,k)~=0 && u(j,k)==0
                            %3
                            x(1, index) = -(u(i,j)*u(i,z)*u(j,z));
                            y(1, index) = -(u(i,k)*u(i,z)*u(k,z));
                            place(1,index) = i; place(2,index) = j; 
                            place(3,index) = k; place(4,index) = z;
                            index = index + 1;
                        elseif u(i,j)==0 && u(i,k)~=0 && u(j,k)~=0
                            %5
                            x(1, index) = -(u(i,k)*u(i,z)*u(k,z));
                            y(1, index) = -(u(j,k)*u(j,z)*u(k,z));
                            place(1,index) = i; place(2,index) = j; 
                            place(3,index) = k; place(4,index) = z;
                            index = index + 1;
                        elseif u(i,j)~=0 && u(i,k)==0 && u(j,k)~=0
                            %6
                            x(1, index) = -(u(i,j)*u(i,z)*u(j,z));
                            y(1, index) = -(u(j,k)*u(j,z)*u(k,z));
                            place(1,index) = i; place(2,index) = j; 
                            place(3,index) = k; place(4,index) = z;
                            index = index + 1;                            
                        end
                    end
        
                end
            end
            
        end
    end
end


% for i = 1 : 113
%     for j = i+1 : 114
%         for k = j+1 : 115
%               for z = k+1 : 116
%                   
%                     [x,y,index] = pair_map_rect(i,j,k,z,x,y,index,u);
%                   
%               end
%                
%          end
%                     
%         
%     end
% end


% for i = 1 : 113
%     for j = i+1 : 114
%         if u(i,j) == 0
%               for k = j+1 : 115
%                 for z = k+1 : 116
%                     if u(i,k,z) ~= 0 && u(j,k,z) ~= 0
%                         x(1, index) = u(i,k,z);
%                         y(1, index) = u(j,k,z);
%                         index = index + 1;
%                     end
%                 end
%               end
%         elseif u(i,j) ~=0
%             for k=j+1:115
%                 if u(i,k) == 0
%                     for z = k+1:116
%                         if u(i,j,z) ~= 0 && u(j,k,z) ~= 0
%                             x(1, index) = u(i,j,z);
%                             y(1, index) = u(j,k,z);
%                             index = index + 1;    
%                         end
%                     end
%                 elseif u(i,k) ~=0
%                     for z=k+1:116
%                         %1
%                         if u(i,j,k) ~= 0 && u(i,j,z) ~= 0  
%                             x(1, index) = u(i,j,k);
%                             y(1, index) = u(i,j,z);
%                             index = index + 1;
%                         end
% 
%                         %2
%                         if u(i,j,k) ~= 0 && u(i,k,z) ~= 0
%                             x(1, index) = u(i,j,k);
%                             y(1, index) = u(i,k,z);
%                             index = index + 1;
%                         end
% 
%                         %3
%                         if u(i,j,z) ~= 0 && u(i,k,z) ~= 0
%                             x(1, index) = u(i,j,z);
%                             y(1, index) = u(i,k,z);
%                             index = index + 1;
%                         end
% 
%                         %4
%                         if u(i,j,k) ~= 0 && u(j,k,z) ~= 0
%                             x(1, index) = u(i,j,k);
%                             y(1, index) = u(j,k,z);
%                             index = index + 1;
%                         end
%                     end
%                 end
%             end
%             
%         end
%     end
% end
                    
% %1        
% if u(i,j)~=0 && u(i,k)~=0 && u(i,z)~=0 && u(j,k)~=0 && u(j,z)~=0 && u(k,z)==0
% end
% 
% %2            
% if u(i,j)~=0 && u(i,k)~=0 && u(i,z)~=0 && u(j,k)~=0 && u(j,z)==0 && u(k,z)~=0
% end
% %3           
% if u(i,j)~=0 && u(i,k)~=0 && u(i,z)~=0 && u(j,k)==0 && u(j,z)~=0 && u(k,z)~=0
% end
% %4          
% if u(i,j)~=0 && u(i,k)~=0 && u(i,z)==0 && u(j,k)~=0 && u(j,z)~=0 && u(k,z)~=0
% end
% %5            
% if u(i,j)==0 && u(i,k)~=0 && u(i,z)~=0 && u(j,k)~=0 && u(j,z)~=0 && u(k,z)~=0
% end
% %6            
% if u(i,j)~=0 && u(i,k)==0 && u(i,z)~=0 && u(j,k)~=0 && u(j,z)~=0 && u(k,z)~=0
% end
% Draw the map:

