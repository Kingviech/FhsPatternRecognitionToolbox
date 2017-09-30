function [ outdata, coeffs ] = scaleZScore( data, coeffs )
    outdata = data;

    if nargin == 1
        coeffs = [mean(data.x);std(data.x)];
    end

    for i = 1:length(coeffs)
        
        % Execute z-score formula
        outdata.x(:, i) = (outdata.x(:, i) - coeffs(1,i)) / coeffs(2,i);
        
    end
end

