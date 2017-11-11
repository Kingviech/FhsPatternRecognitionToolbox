function [ bayes_dens, parzen_dens, prediction ] = minErrParzenClassifier( data ,params )
%MINERRPARZENCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

n = size(data.x,1);

prediction = zeros(n, 1);
bayes_dens = zeros(n, 1);
parzen_dens = zeros(n, 1);

for i = 1:n
    % Acumulator value for finding the optimal value of g
    curDist = -inf;
    for j = 1:params.nClasses
        TestPoint = data.x(i,:);
        dist = TestPoint - params.traindata{j};
        dist = sqrt(sum(abs(dist).^2,2));
        parzen_dens(i) = sum(1/size(params.traindata{j},1) * normpdf(dist, 0, params.sigma));
        g1 = log(parzen_dens(i));
        g2 = log(params.prior(j,1));
        
        bayes_dens(i) = g1 + g2;
        % g must be greater than acumulator value for it to be
        % a better fitting classification than the one of the
        % acumulator
        if(bayes_dens(i) > curDist)
            prediction(i) = params.classes(j);
            curDist = bayes_dens(i);
        end
    end
end

end

