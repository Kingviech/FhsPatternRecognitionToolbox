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
        ni = size(params.traindata{j},1);
        TestPoint = data.x(i,:);
        dist = TestPoint - params.traindata{j};
        dist = sqrt(sum(abs(dist).^2,2));
        g1 = sum(normpdf(dist, 0, params.sigma));
        g2 = log(1/ni * g1);
        g3 = log(params.prior(j,1));
        
        g = g2 + g3;
        % g must be greater than acumulator value for it to be
        % a better fitting classification than the one of the
        % acumulator
        if(g > curDist)
            bayes_dens(i) = g;
            parzen_dens(i) = g1;
            prediction(i) = params.classes(j);
            curDist = bayes_dens(i);
        end
    end
end

end

