function [ outdata, coeffs ] = scaleInterval( data, interval, coeffs )

    outdata = data;
    if nargin < 3
        intervalOld = max(outdata.x) - min(outdata.x);
        coeffs = intervalOld;
    else
        intervalOld = coeffs;
    end
    
    for i = 1:length(intervalOld)
        
        %Scale between [0,1]
        scaledData = (outdata.x(:, i) - min(outdata.x(:,i))) / intervalOld(i);
        
        %scale to any other interval
        outdata.x(:,i) = interval(1) + (interval(2) - interval(1)).*scaledData;
    end
    
end

