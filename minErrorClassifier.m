function [ result ] = minErrorClassifier( mode, data, classifier )
%MINERRORCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here
switch mode
    case 'train'
        uniqueClasses = unique(data.targets);
        numUniqueClasses = size(uniqueClasses, 1);
        
        % Initialize results
        result.classes = uniqueClasses;
        result.means = zeros(numUniqueClasses, size(data.x, 2));
        result.sigmas = zeros(numUniqueClasses, size(data.x, 2), size(data.x, 2));
        result.ps = zeros(numUniqueClasses, 1);
        
        for i = 1 : numUniqueClasses
            curIndices = find(data.targets == uniqueClasses(i));
            
            curDataX = data.x(curIndices, :);                       
            
            % Calculate means
            result.means(i, :) = mean(curDataX);
            
            % Calculate covariances
            result.sigmas(:, :, i) = cov(curDataX);
            
            % Calculate probability of the current class
            result.ps(i,1) = size(curDataX, 1) / size(data.x, 1);
        end
        
    case 'evaluate'
        uniqueClasses = unique(classifier.classes);
        numUniqueClasses = size(uniqueClasses, 1);
        
        numData = size(data.x, 1);
        result = zeros(numData, 1);
        
        dim = size(data.x, 2);
        
        for i = 1 : numData
            % Acumulator value for finding the optimal value of g
            curDist = -inf;
            for j = 1 : numUniqueClasses
                % Calculation of the first part of the g value
                g1 = log((2*pi)^(dim/2) * det(classifier.sigmas(:, :, j))^(1/2));
                
                % Calculation of the second part of the g value of the current data column
                % care about switched Transponation of x mean difference
                % compared to the formula in the presentation
                g2 = 1 / 2 * (data.x(i,:) - classifier.means(j,:)) * inv(classifier.sigmas(:, :, j)) * (data.x(i,:) - classifier.means(j,:))';
                
                % Calculation of the third part of the g value
                g3 = log(classifier.ps(j,1));
                
                % Claculate complete value
                g = - g1 - g2 + g3;
                
                % g must be greater than acumulator value for it to be
                % a better fitting classification than the one of the
                % acumulator
                if(g > curDist)
                    result(i) = uniqueClasses(j);
                    curDist = g;
                end
                
            end
            
        end
    
end

end

