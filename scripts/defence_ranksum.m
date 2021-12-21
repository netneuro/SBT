function [p, eta_squared] = defence_ranksum(data)
% Mann-Whitney/Wilcoxon rank-sum test (U statistics)

% data is a 3 * 80 matrix: 
    % rows represent age group as: 1 = childhood, 2 = adolescence, 3 = adulthood. 
    % Columns represent autism and control group as: 1:40 = participants with autism, 41:80 = healthy controls

% p(i, j) and eta_squared(i,j) where i,j = {1:6 | 1 = children with autism, 2 = healthy children, 3 = adolescents with autism, 
% 4 = healthy adolescents, 5 = adults with autism, 6 = healthy adults.

if ~isempty(data)

    p = zeros(6, 6);
    z = zeros(6, 6);
    stat = cell(6);

    [p(1, 2), ~, stat{1, 2}] = ranksum(data(1, 1:40), data(1, 41:80)); %  children with autism vs healthy children 
    [p(3, 4), ~, stat{3, 4}] = ranksum(data(2, 1:40), data(2, 41:80)); %  adolescents with autism vs healthy adolescents
    [p(5, 6), ~, stat{5, 6}] = ranksum(data(3, 1:40), data(3, 41:80)); %  adults with autism vs healthy adult

    [p(1, 3), ~, stat{1, 3}] = ranksum(data(1, 1:40), data(2, 1:40));  %  children with autism vs adolescents with autism
    [p(1, 4), ~, stat{1, 4}] = ranksum(data(1, 1:40), data(2, 41:80)); %  children with autism vs healthy adolescents
    [p(1, 5), ~, stat{1, 5}] = ranksum(data(1, 1:40), data(3, 1:40));  %  children with autism vs adults with autism
    [p(1, 6), ~, stat{1, 6}] = ranksum(data(1, 1:40), data(3, 41:80)); %  children with autism vs healthy adults

    [p(2, 3), ~, stat{2, 3}] = ranksum(data(1, 41:80), data(2, 1:40));  %  healthy children vs adolescents with autism
    [p(2, 4), ~, stat{2, 4}] = ranksum(data(1, 41:80), data(2, 41:80)); %  healthy children vs healthy adolescents
    [p(2, 5), ~, stat{2, 5}] = ranksum(data(1, 41:80), data(3, 1:40));  %  healthy children vs adults with autism
    [p(2, 6), ~, stat{2, 6}] = ranksum(data(1, 41:80), data(3, 41:80)); %  healthy children vs healthy adults

    [p(3, 5), ~, stat{3, 5}] = ranksum(data(2, 1:40), data(3, 1:40));  %  adolescents with autism vs adults with autism
    [p(3, 6), ~, stat{3, 6}] = ranksum(data(2, 1:40), data(3, 41:80)); %  adolescents with autism vs healthy adults

    [p(4, 5), ~, stat{4, 5}] = ranksum(data(2, 41:80), data(3, 1:40));  %  healthy adolescents vs adults with autism
    [p(4, 6), ~, stat{4, 6}] = ranksum(data(2, 41:80), data(3, 41:80)); %  healthy adolescents vs healthy adults

    p = p' + p;

    for i = 1:5
        for j = i+1:6
            if ~(isempty(stat{i,j}))
                z(i,j) = extractfield(stat{i,j}, 'zval');
            end
        end
    end

    z = z' + z;
    eta_squared = (z .^2) / 80; % eta_squared = z .^ 2 / n, where n is total size of abservation (Tomczak, Maciej, and Ewa Tomczak. "The need to report effect size estimates revisited. An overview of some recommended measures of effect size.", p-23)
else
    p = [];
    eta_squared = [];
end

end

