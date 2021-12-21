

% load('ts_control_base.mat');
x = (1:115);
xq = (1:0.571:115);
vq = cell(1,10);

for i= 1:10
    for j=1:116
        
    v = ts_autism_base{1,i}(:,j);
    vq{1,i}(:,j) = interp1(x,v,xq);
    
    end
end
