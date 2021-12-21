function BrainNet_SmoothSurf(filename,outputfilename,n)
fid = fopen(filename);
data = textscan(fid,'%f','CommentStyle','#');
vertex_number = data{1}(1);
coord  = reshape(data{1}(2:1+3*vertex_number),[3,vertex_number]);
ntri = data{1}(3*vertex_number+2);
tri = reshape(data{1}(3*vertex_number+3:end),[3,ntri])';
fclose(fid);
for i = 1:n
    coord2 = coord;
    parfor j = 1:vertex_number
        [l,~] = find(tri == j);
        cluster = tri(l,:);
        neibor = unique(cluster);
        neibor_v = coord(:,neibor);
        coord2(:,j) = mean(neibor_v,2);
    end
    coord = coord2;
end

fid = fopen(outputfilename,'wt');
fprintf(fid,'%d\n',vertex_number);
for i = 1:vertex_number
    fprintf(fid,'%f %f %f\n',coord2(1:3,i));
end
fprintf(fid,'%d\n',ntri);
for i = 1:ntri
    fprintf(fid,'%d %d %d\n',tri(i,1:3));
end
fclose(fid);
