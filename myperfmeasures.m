function myperfmeasures( data )
%MYPERFMEASURES Summary of this function goes here
%   Detailed explanation goes here
    [ConfMat, order] = confusionmat(data.targets',data.prediction');

    ConfMatTran = ConfMat';
    TP = ConfMatTran(1, 1);
    FP = ConfMatTran(1, 2);
    PP = TP + FP;
    FN = ConfMatTran(2, 1);
    TN = ConfMatTran(2, 2);
    NN = FN + TN;
    N = PP + NN;
    
    fprintf('\nMyPerfMeasures:\n\n');
    
    % Accuracy
    Accuracy = (TP + TN) / N;
    fprintf('Accuracy: %.1f%%\n', Accuracy*100);
    
    % Total Error
    TotalError = (FP + FN) / N;
    fprintf('Total Error: %.1f%%\n', TotalError*100);
    
    % Sensitivity
    Sensitivity = TP / (TP + FN);
    fprintf('Sensitivity: %.1f%%\n', Sensitivity*100);
    
    % Specifity
    Specifity = TN / (TN + FP);
    fprintf('Specifity: %.1f%%\n', Specifity*100);
    
    % Positive Predictive Value (PPV)
    PPV = TP / (TP + FP);
    fprintf('Positive Predictive Value (PPV): %.1f%%\n', PPV*100);
    
    % Negative Predictive Value (NPV)
    NPV = TN / (TN + FN);
    fprintf('Negative Predictive Value (NPV): %.1f%%\n', NPV*100);
    
    % False Rejection Rate (FRR)
    FRR = FP / (TN + FP);
    fprintf('False Rejection Rate (FRR): %.1f%%\n', FRR*100);
    
    % False Acceptance Rate (FAR)
    FAR = FN / (FN + TP);
    fprintf('False Acceptance Rate (FAR): %.1f%%\n', FAR*100);
end

