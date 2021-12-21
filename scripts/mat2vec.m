function [vect] = mat2vec(data, type)
% Feb 2021

roi = 400;

if isequal(type, 'link')
    data = tril(data, -1);
    vect = nonzeros(data, [1,roi*roi]));
elseif isequal(type, 'triad') 
    vect = nonzeros(reshape(data, [1,roi*roi*roi]));

end

