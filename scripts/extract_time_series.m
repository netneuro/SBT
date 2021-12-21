function [time_series] = extract_time_series(number_of_subjects, number_of_regions)


time_series = cell(1,number_of_subjects);

for i=1 : number_of_subjects
     
    matfile = [ 'ROI_Subject', num2str(i, '%03i') ,'_Condition000.mat' ];
%     load(strcat('ts_adol_', num2str(i, '%03i'), '.mat'));
    load (matfile)
    [time_step m] = size (data{1,4});
    
    t = zeros (time_step , number_of_regions); 


    for j = 4: number_of_regions + 3

         t (: , j-3) = data {1,j};
         
    end
     
    time_series {1,i} = t;
    
    OUT_FILE = strcat('ts_adol_', num2str(i, '%03i'));
    save(OUT_FILE , 't');
end

    save('ts_adol', 'time_series');

end

