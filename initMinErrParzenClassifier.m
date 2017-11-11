function [ params ] = initMinErrParzenClassifier( data, sigma )
%INITMINERRPARZENCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

uniqueClasses = unique(data.targets);
numUniqueClasses = size(uniqueClasses, 1);

params.classes = uniqueClasses;
params.nClasses = numUniqueClasses;
params.sigma = sigma;
params.prior = zeros(numUniqueClasses, 1);
params.traindata = struct([]);

for i = 1 : numUniqueClasses
    curIndices = find(data.targets == uniqueClasses(i));

    curDataX = data.x(curIndices, :);
    
    % Calculate probability of the current class
    params.prior(i,1) = size(curDataX, 1) / size(data.x, 1);
    params.traindata{i} = curDataX;
end

end

