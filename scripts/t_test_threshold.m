function [thresholded_data] = t_test_threshold(data, roi)

% data is a 1* n array, n is the number of pariticpants in the group on which t-test will be applied
% global roi_whole_brain
roi_whole_brain = roi;
status = iscell(data);
if status, else, error('the input of t_test_threshold function has to be a cell.'); end

[~, num] = size(data); % num is the number of participants in this group

for s = 1: num
    z{1, s} = atanh(data{1, s}); % Convert r-values (correlations) to z-values
    z{1, s}(boolean(eye(roi_whole_brain))) = 0; % Change the diagonal to zero  
end

% Apply the t-test on each link across the entire group and only keep the links which are significantly different from zero at p-value < 0.05
p_uncorrected = zeros(roi_whole_brain, roi_whole_brain);
for i = 1:roi_whole_brain-1
    for j = i+1: roi_whole_brain
        for s = 1:num
            temp(1, s) = z{1, s}(i,j);
        end
        [~, p_value, ~, ~] = ttest(temp);
        p_uncorrected(i, j) = p_value;
    end
end

p_uncorrected = p_uncorrected' + p_uncorrected;

p_uncorrected(isnan(p_uncorrected)) = 0;
p_FDR = reshape(mafdr(p_uncorrected(:)), size(p_uncorrected)); % FDR correct the p-values

% Create a mask for the group in which only those links are 1 that has survived the t-test's FDR corrected p-values
mask = zeros(roi_whole_brain, roi_whole_brain);
for i = 1:roi_whole_brain-1
    for j = i+1:roi_whole_brain
        if (p_FDR(i,j) ~= 0) && (p_FDR(i,j) < 0.05)
            mask(i,j) = 1;
        end
    end
end

for s = 1:num
    thresholded_data{1, s} = data{1, s} .* mask;
    thresholded_data{1, s} = thresholded_data{1, s}' + thresholded_data{1, s};
end

end

