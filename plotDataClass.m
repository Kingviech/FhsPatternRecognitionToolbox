function plotDataClass(dat, meshdata)

%TODO: für classification boundary notwendig - pimp it!

dimensions=size(dat.x(1,:),2);

if not(isfield(dat,'x')&& isfield(dat,'targets') && isfield(dat,'labels'))
   error('Please check if needed fields: .x, .targets and .labels are found in input datastructure'); 
end

MarkerSize=7;

if dimensions==2
    figure; %open empty figure
    scatter(meshdata.x(:,1),meshdata.x(:,2),[],meshdata.prediction,'+');
    hold on;
    scatter(dat.x(:,1),dat.x(:,2),[MarkerSize],dat.targets,'filled');
    xlabel(dat.labels{1});
    ylabel(dat.labels{2});
    set(gca,'Color',[ 0.5 0.5 0.5])
else
    % no output
    disp('Just 2D supported'); 
end


end %function end