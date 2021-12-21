function output_cell = txt2cell(dir, name_format)

cd(char(dir))
subject_count = input(strcat('Please enter number of participants in ', char(dir), ':'));

for i = 1:80
name = strcat(name_format, num2str(i, '%03i'), '.txt');
fc = corr_harmonized_adol{1, i};
save(name, 'fc', '-ascii');
end

end

