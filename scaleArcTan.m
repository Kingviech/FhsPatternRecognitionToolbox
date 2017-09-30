function [ outdata, coeffs ] = scaleArcTan( data, coeffs )
%SCALEARCTAN Summary of this function goes here
%   Detailed explanation goes here

    outdata = data;

    if nargin == 1
        coeffs = [mean(data.x);std(data.x)];
    end

    for i = 1:length(coeffs)
        
        % Execute z-score formula
        curZ = (outdata.x(:, i) - coeffs(1,i)) / coeffs(2,i);
        
        % Calculate the atan normalization
        outdata.x(:, i) = atan(curZ).*(2/pi);
    end
end

