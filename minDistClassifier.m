function [ result ] = minDistClassifier( mode, data, classifier )

switch mode
    case 'train'
        uniqueClasses = unique(data.targets);
        numUniqueClasses = size(uniqueClasses, 1);
        
        % Initialize results
        result = zeros(numUniqueClasses, size(data.x, 2) + 1);
        
        for i = 1 : numUniqueClasses
            curIndices = find(data.targets == uniqueClasses(i));
            
            curDataX = data.x(curIndices, :);
            
            result(i, 1) = uniqueClasses(i);
            result(i, 2:end) = mean(curDataX);
        end
        
    case 'evaluate'
        uniqueClasses = unique(classifier(:,1));
        numUniqueClasses = size(uniqueClasses, 1);
        
        numData = size(data.x, 1);
        result = zeros(numData, 1);
        for i = 1 : numData
            minDist = inf;
            
            for j = 1 : numUniqueClasses
                dist = norm(data.x(i,:) - classifier(j,2:end));
                if dist <= minDist
                    result(i) = uniqueClasses(j);
                    minDist = dist;
                end
            end
            
        end
end

end

