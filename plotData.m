function plotData(dat, varargin)

    %Appearance of the markers can be changed... check Matlab documentation
    MarkerSize= 7;

    dimensions=size(dat.x(1,:),2);

    if nargin==1  % got no selector
        selector=1:dimensions;
    else
        selector=varargin{1};
    end

    figure; %open empty figure

    dimensions=length(selector);
    
    
    if dimensions==1
        scatter(dat.x(:,selector(1)),zeros(size(dat.x(:,selector(1)),1),1),MarkerSize,dat.targets,'filled');
        xlabel(dat.labels{1});
        grid on;
    elseif dimensions==2
        scatter(dat.x(:,selector(1)),dat.x(:,selector(2)),MarkerSize,dat.targets,'filled');
        xlabel(dat.labels{selector(1)});
        ylabel(dat.labels{selector(2)});
        grid on;
    elseif dimensions==3
        scatter3(dat.x(:,selector(1)),dat.x(:,selector(2)),dat.x(:,selector(3)),MarkerSize,dat.targets,'filled');
        xlabel(dat.labels{selector(1)});
        ylabel(dat.labels{selector(2)});
        zlabel(dat.labels{selector(3)});
        grid on
    elseif dimensions >3
        disp('Cannot plot more than 3 dimensions');
    end

end %function end