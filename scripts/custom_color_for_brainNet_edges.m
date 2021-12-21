
color_edge_b0 = zeros(116,116);


% load ('b0.mat');
% load ('b1.mat');
% load ('b2.mat');
% load ('b3.mat');

% for i=1:1317
%   a =  b3{1,i};
%   b =  b3{2,i};
%   color_edge_b2 (a,b) = 3;
% end

% for i=1:658
%   a =  b2{1,i};
%   b =  b2{2,i};
%   color_edge_b1 (a,b) =2;
% end

% for i=1:359
%   a =  b1{1,i};
%   b =  b1{2,i};
%   color_edge_b0 (a,b) = 1;
% end

for i=1:204
  a =  b0{1,i};
  b =  b0{2,i};
  color_edge_b0 (a,b) = 0;
end

dlmwrite('color_edge_b0_control_ses1.txt',color_edge_b0,'delimiter','\t');

