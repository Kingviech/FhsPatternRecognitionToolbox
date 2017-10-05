function [ outData, EVe ] = calcPrincipalComponents( data, dimReduct )

    % From the Pattern Recognition Scriptum
    
    % Subtract the mean in each coordinate
    % here we use the outer product to do this in an elegant way
    dataCentered = data.x - ones(size(data.x, 1), 1) * mean(data.x, 1);

    % Calculate the covariance matrix
    Sigma = cov(dataCentered);
    
    % Compute eigenvalues and eigenvectors
    [EVe, EVa] = eig(Sigma);
    
    % We take out the eigenvalues from the diagonal matrix and sort them
    % idx contains the sorting index which we need to sort
    % the eigenvectors in the same order
    [EVa, idx] = sort(diag(EVa),'descend');
    
    % Lets resort the eigenvectors
    EVe = EVe(:,idx);
    
    % Now transform the data to the new coordinates by multiplying
    % (this works since the eigenvectors form an orthonormal basis so
    % that coordinates can simply be calculated by the inner product)
    outData.x = (EVe'*dataCentered')';
    outData.targets = data.targets;
    outData.labels = data.labels;
end

