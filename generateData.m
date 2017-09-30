function dat=generateData(mu, sigma, nSamples)

%generates data from a normal distribution. mu and sigma have to be
%specified in the following way:
%
% e.g.: to generate 2-dimensional data (2 features) with 2 classes (0 and 1)
%       with 100 samples for class 0 and 150 samples for class 1:
%
%       mu:       [2 4; 5 7]
%       sigma:    [1 2; 0.5 3]
%       nSamples: [100, 150]
%
%  

dims=size(mu,2);
classes=size(mu,1);

dat.x=[];
dat.targets=[];

for ncla=1:classes
   % generate data for class
   ndata=nSamples(ncla);
   data=randn(ndata,dims);  % N(0,1) numbers
   for i=1:dims
       data(:,i) = data(:,i)*sqrt(sigma(ncla,i))+mu(ncla,i); 
   end
   dat.x=[dat.x ; data];
   dat.targets=[dat.targets ; ones(ndata,1)*(ncla)-1 ]; % 0,1,...
end

for i=1:dims
    dat.labels{i}=['Dim ',num2str(i)];
end

