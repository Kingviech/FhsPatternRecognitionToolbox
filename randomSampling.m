function [ traindata, testdata ] = randomSampling( data, percent, type )
%RANDOMSAMPLING Summary of this function goes here
%   Detailed explanation goes here

    % Ordinary sampling
    if type == 1
        length = size(data.x, 1);

        permErg = randperm(length);

        newDataX = data.x(permErg, :);
        newDataTargets = data.targets(permErg, :);

        traindataCount = floor(length * percent);

        traindata.x = newDataX(1:traindataCount, :);
        traindata.targets = newDataTargets(1:traindataCount, :);
        traindata.labels = data.labels;

        testdata.x = newDataX(traindataCount+1:length, :);
        testdata.targets = newDataTargets(traindataCount+1:length, :);
        testdata.labels = data.labels;
    end

    % Stratified sampling
    if type == 2
        
        traindata.labels = data.labels;
        testdata.labels = data.labels;
        traindata.x = [];
        traindata.targets = [];
        testdata.x = [];
        testdata.targets = [];
        
        
        % Get unique
        uniqueClasses = unique(data.targets);
        for i = 1 : size(uniqueClasses, 1)
           
            % Get indices with the current class
            curIndices = find(data.targets == uniqueClasses(i));
            
            curDataX = data.x(curIndices, :);
            curDataTargets = data.targets(curIndices, :);            
            
            curL = size(curDataX, 1);
            
            curDataCount = floor(curL * percent);
            
            start1 = 1;
            end1 = curDataCount;
            traindata.x = [traindata.x; curDataX(start1:end1, :)];
            traindata.targets = [traindata.targets; curDataTargets(start1:end1, :)];
            
            start2 = curDataCount + 1;
            end2 = curL;
            testdata.x = [testdata.x;curDataX(start2:end2, :)];
            testdata.targets = [testdata.targets;curDataTargets(start2:end2, :)];
            
        end
        
        % Zum Schluss nochmals verwuerfeln (Anm. Labor: für Bayes und neuronale Netze
        % notwendig)
        sizeTrainData = size(traindata.x, 1);
        trainRand = randperm(sizeTrainData);
        traindata.x = traindata.x(trainRand, :);
        traindata.targets = traindata.targets(trainRand, :);
        
        sizeTestData = size(testdata.x, 1);
        testRand = randperm(sizeTestData);
        testdata.x = testdata.x(testRand, :);
        testdata.targets = testdata.targets(testRand, :);
        
    end
    
end

