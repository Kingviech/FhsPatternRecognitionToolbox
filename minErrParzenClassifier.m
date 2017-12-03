function [ bayes_dens, parzen_dens, prediction ] = minErrParzenClassifier( data ,params )
%MINERRPARZENCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

n = size(data.x,1);

prediction = zeros(n, 1);
bayes_dens = zeros(n, 2);
parzen_dens = zeros(n, 2);

for i = 1:n
    % Acumulator value for finding the optimal value of g
    curDist = -inf;
    for j = 1:params.nClasses
        ni = size(params.traindata{j},1);
        TestPoint = data.x(i,:);        
        dist = ones(ni,1) * TestPoint - params.traindata{j};
        dist = sqrt(sum(abs(dist).^2,2));        
        g1 = 1/ni * sum(normpdf(dist, 0, params.sigma));        
        g = log(g1) + log(params.prior(j,1));
        
        parzen_dens(i,j) = g1;
        bayes_dens(i,j) = g;
        
        % g must be greater than acumulator value for it to be
        % a better fitting classification than the one of the
        % acumulator
        if(g > curDist)                       
            prediction(i) = params.classes(j);
            curDist = g;
        end
    end
end

end

