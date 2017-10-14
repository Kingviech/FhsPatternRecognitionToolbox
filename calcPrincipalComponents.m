function [ outData, EVe ] = calcPrincipalComponents( data, dimReduct, coeffs )

    % From https://faculty.iiit.ac.in/~mkrishna/PrincipalComponents.pdf        
    % And from the Pattern Recognition Scriptum
    
    % Subtract the mean in each coordinate
    % here we use the outer product to do this in an elegant way
    dataCentered = data.x - ones(size(data.x, 1), 1) * mean(data.x, 1);

    if nargin == 2
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
        coeffs = EVe;
        
    else
        EVe = coeffs;
    end
    % Now transform the data to the new coordinates by multiplying
    % (this works since the eigenvectors form an orthonormal basis so
    % that coordinates can simply be calculated by the inner product)
    transformedData = (coeffs'*dataCentered')';
    outData.x = transformedData(:,1:dimReduct);
    outData.targets = data.targets;
    outData.labels = data.labels(:,1:dimReduct);
end

